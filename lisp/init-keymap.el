;;; init-keymap.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

; (require 's)

(require 'init-variables)


;; Config form Windows ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq w32-pass-rwindow-to-system nil) ; block right window icon key
(setq w32-pass-lwindow-to-system nil) ; block left window icon key
(setq w32-lwindow-modifier 'super) ; rebind win to super
(w32-register-hot-key [s-])

(setq w32-scroll-lock-modifier 'super)

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'hyper) ; Menu key


;; desprecaed
(defconst lyt-extra-modifier-key "s")

(defun lyt-kbd-with-extra-modifier-key (key)
  "Obsolated - Return kbd code of KEY that combined with `lyt-extra-modifier-key'."
  (kbd (concat lyt-extra-modifier-key "-" key)))





(require 'init-keymap-reset)

(require 'windmove)

(setq windmove-wrap-around t)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)

; (global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)
(global-set-key (kbd "C-j") 'windmove-up)
(global-set-key (kbd "C-k") 'windmove-down)

(winner-mode 1)

;; 3rd packages dependencies ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


 ;; Key-Chord allows us to bind regular keyboard keys for various commands without having to use prefix keys such as Ctrl, Alt or Super etc.
(use-package use-package-chords
  :ensure t
  :init
  :custom((key-chord-two-keys-delay  0.4)
	  (key-chord-one-key-delay 0.5)) ;default 0.2
  :config
  (key-chord-mode 1)
  )

(provide 'init-keymap)


;;; init-keymap.el ends here

