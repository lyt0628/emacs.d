
;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-z l"
        lsp-file-watch-threshold 500)
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-completion-provide :none)
  (setq lsp-headerline-breadcrumb-enable t)
  :bind
  ("C-z l s" . lsp-ivy-workspace-symbol))


(use-package lsp-ui
  :ensure t
  :config
  (define-key lsp-ui-mode-map
	      [remap xref-find-definitions]
	      #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map
	      [remap xref-find-references]
	      #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-position 'top))

(use-package lsp-ivy
  :ensure t
  :after (lsp-mode))



(provide 'init-package-lsp)

;;; init-package-lsp.el ends here
