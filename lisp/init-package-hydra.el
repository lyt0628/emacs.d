;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(use-package hydra :ensure t)

(use-package use-package-hydra
  :ensure t
  :after hydra
  :config
  (defhydra hydra-zoom (global-map "<f2>")
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out")
    ("q" nil "quit" :color blue))
)

(provide 'init-package-hydra)

;;; init-package-hydra.el ends here
