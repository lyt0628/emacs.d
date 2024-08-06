
;;; _init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

;(use-package go-mode-load :ensure t)
;(use-package go-autocomplete :ensure t)

;(require 'auto-complete-config )
;(ac-config-default)

(use-package company-go :ensure t
  :hook
  (go-mode . (lambda ()
               (set (make-local-variable
		     'company-backends)
		    '(company-go))
               )))

(provide 'init-go)
;;; init-go.el ends here

