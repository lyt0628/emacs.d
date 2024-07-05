;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:




(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  :bind ("s-u" . hydra-undo-tree/body)
  :after hydra
  :hydra (hydra-undo-tree (:hint nil)
			  "
	_p_: undo _n_: redo _s_: save _l_: load "
			  ("p" undo-tree-undo)
			  ("n" undo-tree-redo)
			  ("s" undo-tree-save-history)
			  ("l" undo-tree-load-history)
			  ("u" undo-tree-visualize "visualize" :color blue)
			  ("q" nil "quit" :color blue))
  :custom
  (undo-tree-auto-save-history nil))




(provide 'init-package-undo-tree)
;;; init-package-undo-tree.el ends here
