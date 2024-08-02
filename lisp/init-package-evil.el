;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


; 如果不这么做， Evil 不会自动打开!!!
(use-package evil :ensure t
  :config
  (evil-mode))

(use-package evil
  :ensure t
  :custom
  (evil-undo-system 'undo-tree)
  :config
  ;; 我不希望 Evil这个键 占据这么好的位置
  (unbind-key "C-z" 'evil-motion-state-map)
  (unbind-key "C-z" 'evil-insert-state-map)
  (unbind-key "^" 'evil-motion-state-map) ; 由Emacs的替代
  (unbind-key "$" 'evil-motion-state-map)
  ;; 小键盘优先， 这些键应该节省出来
 ; (unbind-key "h" 'evil-motion-state-map)
 ; (unbind-key "j" 'evil-motion-state-map)
 ; (unbind-key "k" 'evil-motion-state-map)
 ; (unbind-key "l" 'evil-motion-state-map)
  (unbind-key "C-d" 'evil-motion-state-map)
  (unbind-key "C-y" 'evil-motion-state-map)
  (unbind-key "C-e" 'evil-motion-state-map)

  (global-set-key (kbd "C-z v") 'hydra-evil/body)
  :bind
  ("S-<up>" . evil-scroll-line-up)
  ("S-<down>" . evil-scroll-line-down)
  ;;比较少用到的 Vim 指令就方这里
  :hydra (hydra-evil (:hint nil)
		     "
    _r_:redo      _j_: join line     _*_: search forward  _#_: search backword
-----------------------------------------------------------------------------------
    _e_:line down _u_:half page down _f_: page down       _b_: page up
-----------------------------------------------------------------------------------
    _q_: quit
"
		     ("r" evil-redo)
		     ("j" evil-join)
		     ("*" evil-search-word-forward)
		     ("#" evil-search-word-backward)
		     ("e" evil-scroll-line-down)
		     ("u" evil-scroll-down)
		     ("f" evil-scroll-page-down)
		     ("b" evil-scroll-page-up)
		     ("q" nil  :color blue))
  :hook
  (evil-local-mode . global-undo-tree-mode)
  )




(provide 'init-package-evil)

;;; init-package-evil.el ends here


