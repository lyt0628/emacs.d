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
(require 's)


(defmacro easyob-defsh-async (name  command )
  "Bind Shell COMMAND call with ARGS to symbol NAME."
  (defalias `,name
	`(lambda ()
	   (async-shell-command
		,command
		,(concat "*" (symbol-name name) "*") ; generate buffer name
		,(s-concat "*" (symbol-name name) "Error !!!*") ;generate error buffer name
		)))
  )


(defmacro easyob-defexe (lang command async
							  filename-prefix extension
							  complete-check-regx complete-prefix complete-subfix
							  head tail
							  file)
  "Dedine org babel execute for LANG."
  (let* (
		   (easyob-defexe-exename (concat "org-babel-execute:"
										   lang))
		   (easyob-defexe-exesymbol (intern easyob-defexe-exename))
		   )
	  (fset easyob-defexe-exesymbol
			`(lambda (body params)
			   (progn
				 (let* (
						(tmp-src-file (org-babel-temp-file ,filename-prefix ,extension))
						(processed-params (org-babel-process-params params))
						)

				   ;; Complete 
				   (unless (and ,complete-check-regx
								(string-match ,complete-check-regx body))
					 (setq body (concat
								 ,complete-prefix
								 body
								 ,complete-subfix))
					 ) ; end unless
				   (setq body (concat ,head body ,tail))

				   ;; Create temp file
				   (with-temp-file tmp-src-file (insert body))

				   ;; Run Command
				   (let* (
						  (processed-command ,command)
						  (processed-command (s-replace "$FILE_SIMPLE" "$FIlE_DIR/$FILE_BASE"
														processed-command))
						  (processed-command (s-replace "$FILE_BASE" (file-name-base tmp-src-file)
														processed-command))
						  (processed-command (s-replace "$FILE_DIR" (file-name-directory tmp-src-file)
														processed-command))
						  (processed-command (s-replace "$FILE" tmp-src-file
														processed-command))
						  (processed-command (s-replace "$BODY" body
														processed-command))
						  (processed-file ,file)
						  (processed-file (s-replace "$FILE_SIMPLE" "$FIlE_DIR/$FILE_BASE"
														processed-file))
						  (processed-file (s-replace "$FILE_BASE" (file-name-base tmp-src-file)
														processed-file))
						  (processed-file (s-replace "$FILE_DIR" (file-name-directory tmp-src-file)
														processed-file))
						  (processed-file (s-replace "$FILE" tmp-src-file
														processed-file))
						  (processed-file (s-replace "$BODY" body
													   processed-file))
						 )
					 (message processed-file)
					 ;; async
					 (when ,async
						 (async-shell-command
						  processed-command
						  ,(concat "*" easyob-defexe-exename "*") ; generate buffer name
						  ,(s-concat "*" easyob-defexe-exename " Error !!!*") )
						 ) ; end async
					 ;; not async
					 (when (not ,async) 
						 (message "FFF")
					   (let* (
							  (result (org-babel-eval processed-command ""))
							  )

						 (unless (s-blank? processed-file)
						   (setq result  processed-file))
						 (when result
						   (org-babel-reassemble-table
							(if (or (member "table" (cdr (assoc :result-params processed-params)))
									(member "vector" (cdr (assoc :result-params processed-params)))
									) ; conditions
								;; if block
								(let* (
									  (tmp-file (org-babel-temp-file ,filename-prefix))
									  ) ; end declaretion
								  (with-temp-file tmp-file (insert (org-babel-trim result)))
								  (org-babel-import-elisp-from-file tmp-file)); end let block
							     ;; else block
								  (org-babel-read (org-babel-trim result) t)) ; end if block
							  (org-babel-pick-name
							   (cdr (assoc :colname-names params)) (cdr (assoc :colnames params)))
							  (org-babel-pick-name
							   (cdr (assoc :rowname-names params)) (cdr (assoc :rownames params)))
							  ;; end else block
							  )); end when result 
						 )); end not async
				   ) ;end run command block

				   ) ;end let*
				 ) ; end progn
			   )) ; end execution bloock
	  ))  ; end easyob-defexe  


;; :head :tail
;; :lang
;; :complete-regx ""
;; :complete "pre %s after"
;; :timeout
;; $FILE

(defmacro easyob-def (name command &rest options)
  "Defin a org-babel execution using COMMAND with name.
Options is a plist. the following keyword are supported.
:lang <language> string type, the languge the babel for. 
     e.g. (easyob-def python 'python $FILE' :lang py)
     and you babel block is
     #+BEGIN_SRC py
         <some python code>
     #+END_SRC

:complete-check-regx <regular expression> string type, if not match, the body of code block will be replaced 
with <value of :complete-prefix> body <value of :complete-subfix>

:complete-prefix <prefix> string type, it will be prefix of body, if complete-check-regx pass.
:complete-subfix <subfix string type, it will be subfix of body, if complete-check-regx pass.

the final body is <head> <complete-prefix> <oiginal body> <complete-subfix> <tail>

you can use some symbol in command, that will be replaced with real value.
$FILE : filename that body tempately store.
$BODY : final body 
"
  (let* (
		 (head (plist-get options :head))
		 (tail (plist-get options :tail))
		 (lang (plist-get options :lang))
		 (extension (plist-get options :extension))
		 (filename-prefix (plist-get options :filename-prefix))
		 (async (plist-get options :async))
		 (timeout (plist-get options :timeout))
		 (complete-check-regx (plist-get options :complete-check-regx))
		 (complete-prefix (plist-get options :complete-prefix))
		 (complete-subfix (plist-get options :complete-subfix))
		 (file (plist-get options :file))
		 )
	(setq head (if head head ""))
	(setq tail (if tail tail ""))
	(setq lang (if lang lang  (symbol-name name)))
	(setq extension (if extension extension ""))
	(setq filename-prefix (if extension filename-prefix ""))
	(setq file (if file file ""))
	(setq timeout (if timeout timeout 6000))
	;(setq async (if async async t))
	(setq complete-prefix (if complete-prefix complete-prefix ""))
	(setq complete-subfix (if complete-subfix complete-subfix ""))

	(macroexp--expand-all `(easyob-defexe ,lang ,command ,async
										  ,filename-prefix ,extension
										  ,complete-check-regx ,complete-prefix ,complete-subfix
										  ,head ,tail
										  ,file))
	
	))

(provide 'easyob)
;;; easyob.el ends here
