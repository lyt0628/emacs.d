

(use-package eglot :ensure nil
  :custom
  (eglot-autoshutdown t)
  :hook (prog-mode . eglot-ensure))


(provide 'init-eglot)
