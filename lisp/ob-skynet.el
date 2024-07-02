;;; ob-skynet.el --- Org-babel functions for skynet  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 lyt0628

;; Author: lyt0628
;; Maintainer: lyt0628
;; Created: 13 April 2024
;; Keywords: lua, skynet, org, babel
;; Homepage: https://github.com/lyt0628/ob-skynet
;; Version: 0.0.1

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Requirements:

;;; Code:


(require 'org-macs)
(require 'f)
(require 's)
(require 'dash)
(require 'uuidgen)
(org-assert-version)

(require 'ob)
(require 'ob-core)
(require 'org-macs)


(declare-function skynet-shell "ext:lua-mode" (&rest args))
(declare-function skynet-choose-shell "ext:lua-mode" (&optional shell))
(declare-function sjynet-shell-send-string "ext:lua-mode" (strg &optional process))


(defvar org-babel-tangle-lang-exts)

(add-to-list 'org-babel-tangle-lang-exts '("skynet" . "skynet"))

(defvar org-babel-default-header-args:skynet '())

(defcustom org-babel-skynet-home nil
  "Home Path of Skynet."
  :version "24.4"
  :package-version '(Org . "8.0")
  :group 'org-babel
  :type 'string)


(defcustom org-babel-skynet-command "skynet"
  "Name of the command for executing Skynet code."
  :version "24.4"
  :package-version '(Org . "8.0")
  :group 'org-babel
  :type 'string)

(defun org-babel-skynet-rename-files (oldnames newnames)
  "OLDNAMES NEWNAMES."
  (let ((oldname (car oldnames))
	(newname (car newnames)))
    (when (and (length> newnames 0)
	       (length> oldnames 0))
      (rename-file oldname newname t)
    (org-babel-skynet-rename-files (cdr oldnames)
			   (cdr newnames)))))



(defconst org-babel-skynet-sparator-regex "^\s*\\+\\+\\+.*\n")


(defun org-babel-skynet-generate-temp-file (body )
  "Generate temporary file for service BODY."
  (let ((tmp-src-file (org-babel-temp-file "skynet-src-" ".lua")))
    (with-temp-file tmp-src-file (insert body))
    tmp-src-file))





(defun org-babel-execute:skynet (body params)
  "Execute a Skynet block of Template code with org-babel. This function is
called by `org-babel-execute-src-block'"
  (when (not org-babel-skynet-home)
    (error "Variable org-babel-skynet-home must be set to reference Home path of skynet"))
  (when (not (executable-find org-babel-skynet-command))
    (error "Variable org-babel-skynet-command must be set to reference executable binary file of skynet"))
  (message "executing Skynet source code block")

  (let* ((org-babel-temporary-directory-old org-babel-temporary-directory)
	 (tmp-service-directory (f-join org-babel-temporary-directory
					  (s-concat "skynet-" (uuidgen-1))))
	 (tmp-src-files (progn
			  (make-directory tmp-service-directory)
			  (setq org-babel-temporary-directory tmp-service-directory)
			  (mapcar
			   'org-babel-skynet-generate-temp-file
			   (-filter #'(lambda (s) (not (s-blank-str? s)))
				    (s-split  org-babel-skynet-sparator-regex body)))))
	 (tmp-cfg-file (org-babel-temp-file "skynet-cfg-" ".conf"))
	 (start-service (f-base (car tmp-src-files)))
	 (service-names (-map #'(lambda (s)
				  (s-trim (s-replace "+++" "" s)))
			      (-flatten (s-match-strings-all
						org-babel-skynet-sparator-regex
						body))))
	 (tmp-appointed-service-files (-map #'(lambda (service-name)
					       (f-join org-babel-temporary-directory
						       (s-concat service-name ".lua")))
					    service-names))
	 (processed-params (org-babel-process-params params))
	 (thread (or (cdr (assq :thread params)) 8))
	 (configs (or (cdr (assq :configs params)) "")))

    (when  (not (length= service-names 0))
      (if (length= service-names (length tmp-src-files))
	  (progn
	    (org-babel-skynet-rename-files tmp-src-files tmp-appointed-service-files)
	    (setq tmp-src-files tmp-appointed-service-files)
	    (setq start-service (f-base (car tmp-src-files))))
	(error "All service' name must be assigned.
                service amount: %d, name amount: %d\n"
	       (length tmp-src-files)
	       (length service-names))))
   
    (with-temp-file tmp-cfg-file (insert (format
					  "
thread = %s
cpath = \"./cservice/?.so\"
bootstrap = \"snlua bootstrap\"

start = \"%s\"
harbor = 0

lualoader = \"./lualib/loader.lua\"
luaservice = \"./service/?.lua;\"..\"./test/?.lua;\" ..\"./test/?/init.lua;\"..%s
lua_path = \"./lualib/?.lua;\" .. \"./lualib/?/init.lua;\" .. %s
lua_cpath = \"./luaclib/?.so\"
%s
"  thread start-service
(s-concat "\"" tmp-service-directory "/?.lua;\"")
(s-concat "\"" tmp-service-directory "/?.lua;\"")
configs)))
(setq org-babel-temporary-directory org-babel-temporary-directory-old)

    
    (let ((results (org-babel-eval
		    (format "cd %s && %s %s"
			    org-babel-skynet-home
			    org-babel-skynet-command
			    tmp-cfg-file
			    ) "")))
      (if results
	  (org-babel-reassemble-table
	   (if (or (member "table" (cdr (assoc :result-params processed-params)))
		   (member "vector" (cdr (assoc :result-params processed-params))))
	     (let ((tmp-file (org-babel-temp-file "skynet-")))
	       (with-temp-file tmp-file (insert (org-babel-trim results)))
	       (org-babel-import-elisp-from-file tmp-file))
	   (org-babel-read (org-babel-trim results) t))
	 (org-babel-pick-name
	  (cdr (assoc :colname-names params)) (cdr (assoc :colnames params)))
	 (org-babel-pick-name
	  (cdr (assoc :rowname-names params)) (cdr (assoc :rownames params))))
	))))




(define-derived-mode skynet-mode lua-mode "Skynet"
  "Major mode for editing Skynet code."
  :group 'skynet)



(provide 'ob-skynet)
;;; ob-skynet.el ends here
