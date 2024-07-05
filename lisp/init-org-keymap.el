;;; init-keymap.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(require 'org)




(setq org-support-shift-select nil) ; 取消 SHift 选择
(unbind-key "S-<up>" 'org-mode-map)
(unbind-key "S-<down>" 'org-mode-map)



(provide 'init-org-keymap)
;;; init-org-keymap.el ends here

