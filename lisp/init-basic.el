;;; init-basic.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

;; Manage key sequence ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package hydra :ensure t)

(use-package use-package-hydra
  :ensure t
  :config
  (defhydra hydra-zoom (global-map "<f2>")
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out")
    ("q" nil "quit" :color blue))
)




;; find symbol ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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




;; Undo Function  to replace default Emacs undo-ring ;;;;;;;;;;;;;;;;;;

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  :bind ("s-u" . hydra-undo-tree/body)
  :after hydra
  :hydra (hydra-undo-tree (:hint nil)
			  ""
			  ("p" undo-tree-undo "undo")
			  ("n" undo-tree-redo "redo")
			  ("s" undo-tree-save-history "save")
			  ("l" undo-tree-load-history "load")
			  ("u" undo-tree-visualize "visualize" :color blue)
			  ("q" nil "quit" :color blue))
  :custom
  (undo-tree-auto-save-history nil))


;; Vim key binding for Emacs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package evil
  :ensure t
  :config
  (evil-mode)
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
  :custom
  (evil-undo-system 'undo-tree)
  :hydra (hydra-evil (:hint nil)
		     ""
		     ("r" evil-redo "redp")
		     ("j" evil-join "join")
		     ("*" evil-search-word-forward "search forward")
		     ("#" evil-search-word-backward "search backword")
		     ("e" evil-scroll-line-down "line down")
		     ("u" evil-scroll-down "half page down")
		     ("f" evil-scroll-page-down "page down")
		     ("b" evil-scroll-page-up "page up")
		     ("q" nil  :color blue))
  :hook
  (evil-local-mode . global-undo-tree-mode)
  )



; Avy allows you to quickly jump to certain character, word or line within the file.
; Use ~jc~, ~jw~ or ~jl~ to quickly jump within current file.
;Change it to other keys, if you feel you are using this set of keys for other purposes.
(use-package avy
:ensure t
:chords
("jc" . gavy-goto-char)
("jw" . avy-goto-word-1)
("jl" . avy-goto-line))



;; command history
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

