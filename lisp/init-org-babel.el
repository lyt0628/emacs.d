;;; init-babel.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(require 'org)

(defvar lyt-note-directory)


(use-package uuidgen :ensure t)
(use-package ob-rust :ensure t)
(use-package ob-latex-as-png :ensure t)
(use-package ob-go :ensure t)
(use-package ob-elixir :ensure t)
(use-package ob-prolog :ensure t)
(org-babel-do-load-languages
  'org-babel-load-languages
      '((js                  . t)
	(python              . t)
	(C                   . t)
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
	(latex-as-png        . t)))



(defconst org-plantuml-jar-path
  "~/data/emacs.d/bin/plantuml-lgpl-1.2024.3.jar")


(define-derived-mode dot-mode graphviz-dot-mode "Dot"
  "Major mode for editing dot code."
  :group 'graphviz-dot)


(require 'ob-skynet)

(setq org-babel-skynet-home (concat lyt-note-directory "skynet/skynet"))


(require 'ob-html)




(setq org-confirm-babel-evaluate nil)

(defconst lyt-babel-library-directory
  (expand-file-name "babel-lib" lyt-note-directory))

(defvar lyt-babel-library-file-list '())

(defun lyt-babel-expand-file-name-in-library-directory (file-name)
  "Expand FILE-NAME in `org-babel-library-directory`."
  (expand-file-name file-name lyt-babel-library-directory))

(defun lyt-babel-expand-file-name-list-in-library-directory (file-name-list)
  "Expand FILE-NAME-LIST in `org-babel-library-directory`."
  (mapcar  (lambda (f)
	    (lyt-babel-expand-file-name-in-library-directory f))
	   file-name-list))

(defun lyt-babel-add-library  (file-list)
  "Add FILE-LIST to the library of babel."
  (apply '+ (mapcar (lambda (f)
		      (setq lyt-babel-library-file-list
			    (cons f lyt-babel-library-file-list))
		      (org-babel-lob-ingest f))
		   file-list)))


(defun lyt-reload-babel-library ()
  "Docstring."
  (interactive )
  (lyt-babel-add-library
   (lyt-util-list-files-in-dir
    lyt-babel-library-directory
    "org"))
  (setq lyt-babel-library-file-list
	(delete-dups lyt-babel-library-file-list)))

(lyt-reload-babel-library)


(provide 'init-org-babel)


;;; init-org-babel.el ends here

