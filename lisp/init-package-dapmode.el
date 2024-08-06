;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(use-package dap-mode
  :ensure t
  :commands dap-debug
  ;; :custom
 ;; (dap-auto-configure-mode t)
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1)
  :hydra
  (hydra-dapmode
   (nil nil)
   ""
   ("b" dap-breakpoint-toggle "toggle breakpoint")
   ("n" dap-next "step next")
   ("i" dap-step-in "step in")
   ("o" dap-step-out)
   ("c" dap-continue "continue")
   ("r" dap-restart-frame)))

(global-set-key (kbd "C-z d") 'hydra-dapmode/body)



(provide 'init-package-dapmode)

;;; init-package-dapmode.el ends here.
