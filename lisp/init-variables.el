;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

;; find out OS type
(if (eq system-type 'windows-nt) ; use Symbol 'windows-nt with eq instead of str "windows-nt" with string=
    (defconst lyt-system-is-windows t)
  (defconst lyt-system-is-windows nil))

(if (eq system-type 'gnu/linux)
    (defconst lyt-system-is-linux t)
  (defconst lyt-system-is-linux nil))

(if (eq system-type 'darwin)
    (defconst lyt-system-is-mac t)
  (defconst lyt-system-is-mac nil))



;; temp variables for using
(defvar lyt-tmp-var nil)
(defvar lyt-tmp-var-1 nil)
(defvar lyt-tmp-var-2 nil)
(defvar lyt-tmp-var-3 nil)



;; load configuration for different OS type
(when lyt-system-is-linux
  (defconst lyt-emacs-directory "~/data/emacs.d/") "My custom Emacs configuration dir")

(when lyt-system-is-windows
  (defconst lyt-emacs-directory "e:/emacs.d/") "My custom Emacs configuration dir")


(defconst lyt-original-emacs-directory "~/.emacs.d/" "Default Emacs configuration directory.")


(setq custom-file
   (expand-file-name "custom.el" lyt-emacs-directory))
(load custom-file)


;; I hold different bookmark for different OS machine
(require 'bookmark)
(when lyt-system-is-linux
  (setq bookmark-default-file
	(expand-file-name "bookmark-linux.el" lyt-emacs-directory)))

(when lyt-system-is-windows
  (setq bookmark-default-file
	(expand-file-name "bookmark-win.el" lyt-emacs-directory)))

(defconst lyt-yas-dirs (list
			(expand-file-name "yasnippets"
					  lyt-emacs-directory)
			)
  )

(provide 'init-variables)
;;; init-variables.el ends here
