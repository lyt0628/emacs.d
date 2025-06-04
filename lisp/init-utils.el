;;; _init.el --- Intializing file
;;; Commentary:
;; Utils for config Emacs behaviour.
;; Most needs is simple, unless necessary, dont require extenal lib.
;;; Code:
(require 'package)


(defun my/util/add-to-load-path (dir)
  "Add DIR to Emacs `load-path'."
  (add-to-list 'load-path dir))

(defun my/util/add-to-package-repo (name url)
  "Add URL to `package-archives' with NAME."
  (add-to-list 'package-archives `(,name . ,url)))



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

;; Delete the current file

(defun my/i/delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (unless (buffer-file-name)
    (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))


(if (fboundp 'rename-visited-file)
    (defalias 'my/i/rename-this-file-and-buffer 'rename-visited-file)
  (defun my/i/rename-this-file-and-buffer (new-name)
    "Renames both current buffer and file it's visiting to NEW-NAME."
    (interactive "sNew name: ")
    (let ((name (buffer-name))
          (filename (buffer-file-name)))
      (unless filename
        (error "Buffer '%s' is not visiting a file!" name))
      (progn
        (when (file-exists-p filename)
          (rename-file filename new-name 1))
        (set-visited-file-name new-name)
        (rename-buffer new-name)))))


;; Browse current HTML file

(defun my/i/browse-current-file ()
  "Open the current file as a URL using `browse-url'."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (and (fboundp 'tramp-tramp-file-p)
             (tramp-tramp-file-p file-name))
        (error "Cannot open tramp file")
      (browse-url (concat "file://" file-name)))))


(provide 'init-utils)
;;; init-utils.el ends here.
