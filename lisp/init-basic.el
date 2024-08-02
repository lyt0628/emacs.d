;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
(require 'init-package-hydra)

(require 'init-package-undo-tree)

(require 'init-package-evil)

(require '_init-package-ivy)

(require 'init-package-avy)

(require 'init-package-dapmode)

;command history
(use-package amx
  :ensure t
  :config
  (amx-mode))


(use-package which-key
  :ensure t
  :init (which-key-mode))


(use-package marginalia
  :ensure t
  :init (marginalia-mode)
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle)))


(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs!")
  (setq dashboard-startup-banner 'official)
  (setq dashboard-items '((recents . 5)
			  (bookmarks . 5)
			  (projects . 10)))
  (dashboard-setup-startup-hook))

;; m1\n10 | int func%02d ()
;; M-x tiny-expand
(use-package tiny
  :ensure t)


(use-package highlight-symbol
  :ensure t
  :init (highlight-symbol-mode)
  :bind
  ("<f3>" . highlight-symbol))



(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package pdf-tools
  :ensure t
  :bind)




(provide 'init-basic)

;;; init-basic.el ends here

