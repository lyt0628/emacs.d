;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


(require 'lsp-clangd)

(setq lsp-clangd-binary-path
      (executable-find "clangd"))

(require 'dap-cpptools)



(provide 'init-prog-c-cpp)


;;; init-prog-c-cpp.el ends here
