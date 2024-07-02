;;; init-babel.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(require 'org)

(setq org-confirm-babel-evaluate nil)

(defvar lyt-note-directory)


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





(lyt-babel-add-library
  (lyt-util-list-files-in-dir
   (concat lyt-note-directory "babel-lib/" )
   "org"))


(defun lyt-reload-babel-library ()
  "Docstring."
  (interactive )
  (lyt-babel-add-library lyt-babel-library-file-list)
  (setq lyt-babel-library-file-list
	(delete-dups lyt-babel-library-file-list)))

(require 'ob-skynet)

(setq org-babel-skynet-home (concat lyt-note-directory "skynet/skynet"))

(provide 'init-babel)


;;; init-babel.el ends here

