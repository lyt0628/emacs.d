;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
(require 'init-hydra)


; 如果不这么做， Evil 不会自动打开!!!
(use-package evil :ensure t
  :config
  (evil-mode))

(use-package evil
  :ensure t
  :config
  ;; 删除一些emacs和vim冲突的命令
  ;(unbind-key "C-a") 这两个键比im 的好用
  ;(unbind-key "C-e")
  (unbind-key "C-y")
  (unbind-key "C-d")
  ;; 我不希望 Evil这个键 占据这么好的位置
  (unbind-key "C-z" 'evil-motion-state-map)
  (unbind-key "C-z" 'evil-insert-state-map)
  (unbind-key "C-z") ; and not want to syspend Emacs
  (unbind-key "^" 'evil-motion-state-map) ; 由Emacs的替代
  (unbind-key "$" 'evil-motion-state-map)
  (setq evil-undo-system 'undo-tree) ; 使用 Undo-tree 原生指令 作为undo 后端

  ;; 小键盘优先， 这些键应该节省出来
  (unbind-key "h" 'evil-motion-state-map)
  (unbind-key "j" 'evil-motion-state-map)
  (unbind-key "k" 'evil-motion-state-map)
  (unbind-key "l" 'evil-motion-state-map)
  (unbind-key "C-d" 'evil-motion-state-map)
  (unbind-key "C-y" 'evil-motion-state-map)
  (unbind-key "C-e" 'evil-motion-state-map)


  :bind
  ("S-<up>" . evil-scroll-line-up)
  ("S-<down>" . evil-scroll-line-down)
  ("s-v" . hydra-evil/body)
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
  )



(provide 'init-evil)
;;; init-evil.el ends here

