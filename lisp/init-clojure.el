;;; init-clojure.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
(use-package clojure-mode
  :ensure t)


(use-package  cider
  :ensure t
  :config (add-hook 'clojure-mode-hook 'cider-mode))


(use-package clj-refactor
  :ensure t
  :config (add-hook 'clojure-mode 'clj-refactor))

(use-package paredit
  :ensure t
  :config (add-hook 'clojure-mode-hook 'paredit-mode))

(provide 'init-clojure)

;;; init-clojure.el ends here

  
