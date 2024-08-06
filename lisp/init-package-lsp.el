
;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-file-watch-threshold 500)
  :hook
  ((lsp-mode . lsp-enable-which-key-integration)

   (c-mode . lsp-deferred)
   (c++-mode . lsp-deferred)
   (python-mode . lsp-deferred)
   (go-mode . lsp-deferred)

   (before-save-hook  lsp-format-buffer)
   (before-save-hook  lsp-organize-imports))
  :config
  (setq lsp-completion-provide :none)
  (setq lsp-headerline-breadcrumb-enable t)
  :bind
  ("s-l s" . lsp-ivy-workspace-symbol))


(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)


(use-package lsp-ivy
  :ensure t
  :commands
   lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)


(require 'init-package-lsp-cpp)

(provide 'init-package-lsp)

;;; init-package-lsp.el ends here
