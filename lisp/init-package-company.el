;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:




(use-package company
  :ensure t
  :init
  (global-company-mode)
  :custom
  (company-minimum-prefix-length 1) ; 我希望它晚点触发，为了性能考虑
  (company-tooltip-align-annotations t)
  (company-idle-delay 0.0)
  (company-show-quick-access t); 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (company-selection-wrap-around t)
  (company-tabnine-wait 0.25)
  (company-transformers '(company-sort-by-occurrence))
  ) ; 根据选择的频率进行排序

(use-package company-box
  :ensure t
  :if window-system
  :hook (company-mode . company-box-mode))



;(use-package company-tabnine
;  :ensure t
;  :init
;  (add-to-list 'company-backends
;	       #'company-tabnine))


(provide 'init-package-company)
;;; init-package-company.el ends here

