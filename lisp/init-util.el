;;; init-util.el --- Provide Basic uitl for emacs lisp -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(require 'package)


(defun lyt-util-add-to-load-path  (dir)
  "Add DIR for Emacs to find lib.  As is add it to `load-path'."
  (add-to-list 'load-path dir))


(defun lyt-util-add-to-load-path-if-exists (dir)
  "Add DIR for Emacs to find lib if DIR exists.  As is add it to `load-path'."
  (when (file-exists-p dir)
    (lyt-util-add-to-load-path dir)))


(defun lyt-util-add-remote-package-repository (name url)
  "ADD URL with NAME to remote repositories for Emacs to find package."
  (add-to-list 'package-archives `(,name . ,url)))


(defun lyt-util-list-files-in-dir (dir &optional extension)
  "Return list of files in DIR,Filter by EXTENSION."
  (let ((pattern ".*"))
       (when extension
	 (setq pattern (concat ".*\\." extension "$")))

       (cl-mapcan (lambda (file)
		    (when (file-regular-p file)
		      (list file)))
		  (directory-files dir t
				   pattern))))


(defun lyt-util-concat (sequence separator &optional end-string)
  "Concat SEQUENCE by SEPARATOR, wrapped with END-STRING if any."
  (setq-default end-string "")
  (concat end-string
	  (mapconcat 'identity
		     sequence separator)
	  end-string))


(defun lyt-util-rename-files (oldnames newnames)
  "Rename OLDNAMES to NEWNAMES by order."
  (let ((oldname (car oldnames))
	(newname (car newnames)))
    (when (and (length> newnames 0)
	       (length> oldnames 0))
      (rename-file oldname newname)
    (lyt-util-rename-files (cdr oldnames)
			   (cdr newnames)))))






(provide 'init-util)


;;; init-util.el ends here
