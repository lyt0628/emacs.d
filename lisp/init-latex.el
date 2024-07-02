



(use-package auctex
  :ensure t)

(use-package cdlatex
  :ensure t
  :hook (org-mode-hook turn-on-org-cdlatex))

(use-package auctex :ensure t)

(executable-find "dvipng")

(executable-find "dvisvgm")


