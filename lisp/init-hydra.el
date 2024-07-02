;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


(use-package hydra
  :ensure t)

(use-package use-package-hydra
  :ensure t
  :after hydra
  :config
  (defhydra hydra-zoom (global-map "<f2>")
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out")
    ("q" nil "quit" :color blue))
  
  (defhydra hydra-bookmark (nil nil)
    "bookmark  "
    ("m" bookmark-set "mark")
    ("j" bookmark-jump "jump")
    ("l" bookmark-bmenu-list "list")
    ("x" bookmark-delete "delete")
    ("q" nil "quit" :color blue))
  (global-set-key (kbd "s-m") 'hydra-bookmark/body)
)




(provide 'init-hydra)

;;; init-hydra.el ends here
