
(use-package company
  :ensure t
  :commands (global-company-mode)
  :init
  (global-company-mode)
  :custom
  (company-tooltip-align-annotations 't)
  (company-idle-delay 0.0)
  (company-selection-wrap-around t)
  (company-transformers '(company-sort-by-occurrence))
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-idle-delay 0.1))

(use-package company-box
  :ensure t
  :if (display-graphic-p)
  :hook (company-mode . company-box-mode))


(provide 'init-company)

;;; init-company.el ends here
