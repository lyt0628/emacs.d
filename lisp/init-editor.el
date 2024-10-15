;;; init-editor.el --- Change Emacs editor Basic Behavior for better usage -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


(setq make-backup-files nil)

(defconst *spell-check-support-enabled* nil)



;; Adjust garbage collection threshold for early startup (see use of gcmh below)
(setq gc-cons-threshold 300000000) ; 300mb
; Process performance tuning
(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)
(setq gc-cons-percentage 0.1)



;; Behaviour ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq ring-bell-function 'ignore) ; Disable annoying ring-bell
(electric-pair-mode t) ; automatically fit paren
(show-paren-mode 1)
(add-hook 'prog-mode-hook #'hs-minor-mode) ; enable fold code trunk
(global-auto-revert-mode t ) ; immediately update buffer when other app modified file
(delete-selection-mode t) ; modify selection when keydown

;; query when closing Emacs
(setq confirm-kill-emacs #'yes-or-no-p)
(setq confirm-kill-processes nil) ; We don't care

;; Showing img when babel gen some images
(add-hook 'org-babel-after-execute-hook
	  'org-redisplay-inline-images)


;(global-visual-line-mode 1) ; Enable soft-wrap

;; Maintain a list of recent files opened
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 50)


;; Move all the backup files to specific cache directory
;; Following setting will move temporary files to specific folders inside cache directory
(require 'init-variables)
(setq user-cache-directory
      (concat lyt-original-emacs-directory "cache"))
(setq backup-directory-alist `(("." . ,(expand-file-name "backups" user-cache-directory)))
      url-history-file (expand-file-name "url/history" user-cache-directory)
      auto-save-list-file-prefix (expand-file-name "auto-save-list/.saves-" user-cache-directory)
      projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" user-cache-directory))


;; Org-mode issue with src block not expanding
;; This is a fix for bug in org-mode where <s TAB does not expand SRC block
(when (version<= "9.2" (org-version))
(require 'org-tempo))


;; This will help eliminate weird escape sequences during compilation of projects.
(defun _/ansi-colorize-buffer () ; I use _ namespace for those func used just one time
  "."
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))

(use-package ansi-color
  :ensure t
  :config
  (add-hook 'compilation-filter-hook '_/ansi-colorize-buffer)
  )

;; Aperence ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(column-number-mode t) ; show line number
(setq inhibit-startup-message t) ; close welcome tab
(global-display-line-numbers-mode 1) ; show line number in window
(tool-bar-mode -1) ; close tool-bar
(when (display-graphic-p)
  (toggle-scroll-bar -1)) ; close scroll-bar

(set-face-attribute 'default nil :height 120)
;(setq display-line-numbers-type 'relative) ; relative line number
;(add-to-list 'default-frame-alist '(width . 90))

;; Two theme. dark one *doom-themes* and light-dark toggle one *haven-andhell*
(use-package doom-themes
:ensure t
:init
(load-theme 'doom-palenight t))

(use-package heaven-and-hell
  :ensure t
  :custom (
	   (heaven-and-hell-theme-type 'dark)
	   (heaven-and-hell-themes
	    '((light . doom-acario-light)
              (dark . doom-palenight)))
	   )
  :hook (after-init . heaven-and-hell-init-hook)
  :bind (("C-c <f6>" . heaven-and-hell-load-default-theme)
         ("<f6>" . heaven-and-hell-toggle-theme)))

;; Common icons for emacs
(use-package all-the-icons :ensure t)



(defvar org-display-inline-images)
(defvar org-redisplay-inline-images)
(defvar org-startup-with-inline-images)


(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images "inlineimages")





;; Charset for supportin chinese ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(setq default-file-name-coding-system "utf-8")
(prefer-coding-system 'utf-8)

;; Adapt for Chinese
(set-fontset-font t 'han
		  (font-spec
		   :family "Microsoft YaHei"
		   :size 17))








;; Indentation setting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
(setq tab-always-indent t) ; alawy indent
(setq indent-tabs-mode nil) ; ？
(setq-default tab-width 4)




(provide 'init-editor )

;;; init-editor.el ends here

