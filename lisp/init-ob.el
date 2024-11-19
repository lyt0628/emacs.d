;;; init-babel.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(require 'org)

(require 'easyob)
(defvar lyt-note-directory)



(setq org-confirm-babel-evaluate nil)

(use-package uuidgen :ensure t)

(use-package ob-rust :ensure t)
(use-package ob-go :ensure t)
(use-package ob-elixir :ensure t)
(use-package ob-prolog :ensure t)

(use-package graphviz-dot-mode :ensure t
  :config
  (define-derived-mode dot-mode graphviz-dot-mode "Dot"
  "Major mode for editing dot code."
  :group 'graphviz-dot))
;; End of use-package


(easyob-def tex
			"pdflatex -shell-escape -output-directory=$FILE_DIR $FILE  && pdftoppm $FILE_SIMPLE.pdf -png $FILE_SIMPLE"
			:extension ".tex"
			:file "$FILE_SIMPLE-1.png"
			:head "
\\documentclass[varwidth,crop]{standalone}
\\usepackage[greek,english]{babel}
\\begin{document}"
			:tail "
\\end{document}"
			)

(easyob-def mysqlsh
			"echo $BODY | mysqlsh -u root")


(use-package plantuml-mode :ensure t
  :custom
  (org-plantuml-jar-path  (concat lyt-emacs-directory "bin/plantuml-bsd-1.2024.7.jar")))

;; End of use-package


(org-babel-do-load-languages
  'org-babel-load-languages
      '((js                  . t)
		(python              . t)
		(C                   . t)
		(java                . t)
		(go                  . t)
		(lua                 . t)
		(emacs-lisp          . t)
		(clojure             . t)
		(ruby                . t)
		(rust                . t)
		(elixir              . t)
		(prolog              . t)
		(shell               . t)
		(css                 . t)
		(awk                 . t)
		(sql                 . t)
		(plantuml            . t)
		(dot                 . t)
 
		))


;(require 'ob-skynet)

;(setq org-babel-skynet-home (concat lyt-note-directory "skynet/skynet"))


;(require 'ob-html)



;; Manage ob libs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst lyt-ob-lib-dir
  (expand-file-name "babel-lib" lyt-note-directory))

(defvar lyt-ob-lib-file-list '())

(defun lyt-ob-expand-file-name-in-lib-dir(file-name)
  "Expand FILE-NAME in `org-babel-library-directory`."
  (expand-file-name file-name lyt-ob-lib-dir))

(defun lyt-ob-expand-file-name-list-in-lib-dir(file-name-list)
  "Expand FILE-NAME-LIST in `org-babel-library-directory`."
  (mapcar  (lambda (f)
	    (lyt-ob-expand-file-name-in-lib-dirf))
	   file-name-list))

(defun lyt-ob-add-lib(file-list)
  "Add FILE-LIST to the library of babel."
  (apply '+ (mapcar (lambda (f)
		      (setq lyt-ob-lib-file-list
			    (cons f lyt-ob-lib-file-list))
		      (org-babel-lob-ingest f))
		   file-list)))


(defun lyt-ob-reload-lib()
  "Docstring."
  (interactive )
  (lyt-ob-add-lib
   (lyt-util-list-files-in-dir
    lyt-ob-lib-dir
    "org"))
  (setq lyt-ob-lib-file-list
	(delete-dups lyt-ob-lib-file-list)))

(lyt-ob-reload-lib)





;; ob-java ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(require 'ob-java)

;(defvar lyt-ob-java-lib-dir "~/")
;(defvar org-babel-default-header-args:java '())
;(let ((library-files (mapconcat 'identity
;				(lyt-util-list-files-in-dir
;				 lyt-ob-java-lib-dir
;				 "jar")
;				":")))
; (nconc org-babel-default-header-args:java
;	 `((:dir . "workdir")
;	   (:cmpflag . ,(concat "-cp " library-files))
;	   (:cmdline . ,(concat "-cp .:"  library-files)))))



(provide 'init-ob)


;;; init-ob.el ends here
