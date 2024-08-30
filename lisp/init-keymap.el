;;; init-keymap.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

; (require 's)

(require 'init-variables)

(defun lyt-kbd-with-extra-modifier-key (key)
  "Return kbd code of KEY that combined with `lyt-extra-modifier-key'."
  (kbd (concat lyt-extra-modifier-key "-" key)))

(require 'init-keymap-reset)

(require 'windmove)

(setq windmove-wrap-around t)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)

(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)
(global-set-key (kbd "C-j") 'windmove-up)
(global-set-key (kbd "C-k") 'windmove-down)



(winner-mode 1)












(provide 'init-keymap)


;;; init-keymap.el ends here

