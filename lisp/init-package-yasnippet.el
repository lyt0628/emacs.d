;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
(require 'init-keymap)

(use-package yasnippet
  :ensure t
  :hook
  (prog-mode . yas-minor-mode)
  (org-mode . yas-minor-mode)
  :config
  (yas-reload-all)
;  (setq yas-snippet-dirs (append yas-snippet-dirs
;                                '("~/Downloads/interesting-snippets")))
  ;; add company-yasnippet to company-backends
  (defun company-mode/backend-with-yas (backend)
    (if (and (listp backend) (member 'company-yasnippet backend))
	     backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

  ;; using C+<tab> to expand instead of default <tab>
  ;;(define-key yas-minor-mode-map [(tab)]        nil)
  ;;(define-key yas-minor-mode-map (kbd "TAB")    nil)
  ;;(define-key yas-minor-mode-map (kbd "<tab>")  nil)
  :bind
  (:map yas-minor-mode-map ("C-<tab>" . yas-expand))
  :hydra (hydra-yasnippet (:hint nil)
			  "snippet:"
			  ("n" yas-new-snippet "new" :color blue)
			  ("s" yas-load-snippet-buffer-and-close "save snippet")
			  ("t" yas-tryout-snippet "try snippet")
			  ("v" yas-visit-snippet-file "visit snippet")
			  ("q" nil "quit")))

(global-set-key (lyt-kbd-with-extra-modifier-key "s") 'hydra-yasnippet/body)


(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)
(global-set-key (kbd "M-/") 'hippie-expand)



(provide 'init-package-yasnippet)

;;; init-package-yasnippet.el ends here
