;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


(if (string= system-type "windows-nt")
    (defconst lyt-system-is-windows t)
  (defconst lyt-system-is-windows nil))	

(if (string= system-type "gnu/linux")
    (defconst lyt-system-is-linux t)
  (defconst lyt-system-is-linux nil))	





(defvar lyt-tmp-var nil)
(defvar lyt-tmp-var-1 nil)
(defvar lyt-tmp-var-2 nil)
(defvar lyt-tmp-var-3 nil)



(defconst lyt-extra-modifier-key "s")


(when lyt-system-is-linux
  (defconst lyt-emacs-directory "~/data/emacs.d/"))

(when lyt-system-is-windows
  (defconst lyt-emacs-directory "e:/emacs.d/"))



(setq custom-file
   (expand-file-name "custom.el" lyt-emacs-directory))
(load custom-file)


(when lyt-system-is-linux
  (setq bookmark-file
	(expand-file-name "bookmark-linux.el" lyt-emacs-directory)))

(when lyt-system-is-windows
  (setq bookmark-file
	(expand-file-name "bookmark-win.el" lyt-emacs-directory)))



(provide 'init-variables)
;;; init-variables.el ends here
