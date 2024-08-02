
;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


(use-package counsel
	:ensure t)

(use-package ivy
	:ensure t
	:config
	(ivy-mode 1)
	(counsel-mode 1)
	(setq ivy-use-virtual-buffers t)
	(setq search-default-mode #'char-fold-to-regexp)
	(setq ivy-count-format "(%d/%d) ")
	:bind
	(("C-s" . 'swiper)
	 ("C-x b" . 'ivy-switch-buffer)
	 ("C-x C-@" . 'counsel-mark-ring)
	 ("C-x C-SPC" . 'counsel-mark-ring )
		:map minibuffer-local-map
		("C-r" . counsel-minibuffer-history))
	:bind ("C-z w" . hydra-ivy-view/body)
	:hydra (hydra-ivy-view (:hint nil)
	""
	("s" ivy-push-view "save")
	("j" ivy-switch-view "jump")
	("x" ivy-pop-view "delete")
	("q" nil "quit")))



(provide '_init-package-ivy)

;;; _init-package-ivy.el ends here.
