
;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


(require 'lsp-clangd)


(setq lsp-clangd-binary-path
      (executable-find "clangd-15"))

(require 'dap-cpptools)

(dap-register-debug-template
  "Emacs --- Debug"
  (list :type "cppdbg"
        :request "launch"
        :name "Emacs --- Debug"
        :MIMode "gdb"
        :program "${workspaceFolder}/src/emacs"
        :cwd "${workspaceFolder}"))

(provide 'init-package-lsp-cpp)

;;; init-package-lsp-cpp.el ends here
