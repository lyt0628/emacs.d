;;; init-keymap.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(require 'org)




(setq org-support-shift-select nil) ;  shift ext-select
(unbind-key "S-<up>" 'org-mode-map)
(unbind-key "S-<down>" 'org-mode-map)

(unbind-key "C-k" 'org-mode-map) ; org-kill-line
(unbind-key "C-j" 'org-mode-map) ; org-return-and-maybe-indent

(provide 'init-org-keymap)
;;; init-org-keymap.el ends here

