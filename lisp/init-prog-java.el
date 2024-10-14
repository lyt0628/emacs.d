;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(use-package lsp-java
  :ensure t
  :hook (java-mode . #'lsp))

(use-package dap-java :ensure nil)


(provide 'init-prog-java)

;;; init-prog-java.el ends here

