;;; ob-html.el --- Org-babel functions for skynet  -*- lexical-binding: t; -*-

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

(require 'ob)
(require 'ob-eval)
(require 'ob-ref)
(require 'f)

;; optionally define a file extension for this language
(defvar org-babel-tangle-lang-exts)
(add-to-list 'org-babel-tangle-lang-exts '("html" . "html" ))


(defvar org-babel-default-header-args:html '())

(defun org-babel-execute:html (body params)
  "Open HTML Code in browser with org-babel.
This function is called by `org-babel-execute-src-block'."
  (message "executing HTML source code in broser")
  (let* ((tmp-src-file (org-babel-temp-file "html-src-" ".html"))
         (processed-params (org-babel-process-params params))
	 (dir (cdr (assq :dir processed-params)))
         (coding-system-for-read 'utf-8) ;; use utf-8 with subprocesses
         (coding-system-for-write 'utf-8))
    (with-temp-file tmp-src-file (insert body))

    (when dir
      (f-copy tmp-src-file
		 (s-concat (f-base tmp-src-file) ".html"))
      (setq tmp-src-file (s-concat (f-base tmp-src-file) ".html")))
    (let ((results
     (org-babel-eval
      (format "google-chrome  %s "  tmp-src-file )
      "")))

      (when results
        (org-babel-reassemble-table
         (if (or (member "table" (cdr (assoc :result-params processed-params)))
           (member "vector" (cdr (assoc :result-params processed-params))))
       (let ((tmp-file (org-babel-temp-file "html-")))
         (with-temp-file tmp-file (insert (org-babel-trim results)))
         (org-babel-import-elisp-from-file tmp-file))
     (org-babel-read (org-babel-trim results) t))
         (org-babel-pick-name
    (cdr (assoc :colname-names params)) (cdr (assoc :colnames params)))
         (org-babel-pick-name
    (cdr (assoc :rowname-names params)) (cdr (assoc :rownames params))))))))



(defun org-babel-prep-session:rust (_session _params)
  "This function does nothing.."
  (error "HTML not supports for sessions"))


(provide 'ob-html)
;;; ob-html.el ends here
