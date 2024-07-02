;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
(require 'init-hydra)


; 用于替换基础的功能因此不必添加快捷键
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
	:bind ("s-w" . hydra-ivy-view/body)
	:hydra (hydra-ivy-view (:hint nil)
	"
	_s_: save window _j_: jump _s_: save _q_: quit "
	("s" ivy-push-view)
	("j" ivy-switch-view)
	("x" ivy-pop-view)
	("q" nil "quit")))

(provide 'init-ivy)
;;; init-ivy.el ends here
