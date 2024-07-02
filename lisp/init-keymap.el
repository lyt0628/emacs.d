;;; init-keymap.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(require 'windmove)


;; Set WindMove
(setq windmove-wrap-around t)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)

(winner-mode 1)


; 没人会花时间去手打非打印字符
(unbind-key "C-q")



(require 'org)

;; 取消 SHift 选择
(setq org-support-shift-select nil)
(unbind-key "S-<up>" 'org-mode-map)
(unbind-key "S-<down>" 'org-mode-map)

(provide 'init-keymap)


;;; init-keymap.el ends here

