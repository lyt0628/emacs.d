;;; init-behavior.el --- Fix Emacs Basic Behavior for better usage -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:



(setq make-backup-files nil)


(defconst *spell-check-support-enabled* nil)

(defconst *is-a-mac* (eq system-type 'darwin))


; Adjust garbage collection threshold for early startup (see use of gcmh below)
(setq gc-cons-threshold (* 128 1024 1024))
; Process performance tuning
(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)

; query when closing Emacs
(setq confirm-kill-emacs #'yes-or-no-p)
(setq confirm-kill-processes nil) ; We don't care



(electric-pair-mode t) ; automatically fill paren

(column-number-mode t) ; show line number
(global-auto-revert-mode t ) ; immediately update buffer when other app modified file
(delete-selection-mode t) ; modify selection when keydown
(add-hook 'prog-mode-hook #'hs-minor-mode) ; fold code trunk
(setq inhibit-startup-message t) ; close welcome tab
(global-display-line-numbers-mode 1) ; show line number in window
(tool-bar-mode -1) ; close tool-bar
(when (display-graphic-p) (toggle-scroll-bar -1)) ; close scroll-bar














(defvar org-display-inline-images)
(defvar org-redisplay-inline-images)
(defvar org-startup-with-inline-images)


(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images "inlineimages")

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)




;; optional settings
;(setq display-line-numbers-type 'relative) ; relative line number
; (add-to-list 'default-frame-alist '(width . 90))



;; theme settings
(set-face-attribute 'default nil :height 120)



;; Charset for supportin chinese
(set-language-environment "UTF-8")

(set-default-coding-systems 'utf-8)

(setq default-file-name-coding-system "utf-8")

(prefer-coding-system 'utf-8)

(set-fontset-font t 'han (font-spec :family "Microsoft YaHei" :size 36))



						
(setq tab-always-indent nil) ; 是否关闭任意缩进


(setq indent-tabs-mode nil) ; ？

(setq tab-width 2)


(require 'org-cycle)
(setq org-cycle-emulate-tab 'exc-hl-bol)

(provide 'init-behavior )

;;; init-behavior.el ends here

