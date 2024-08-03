;;; init-keymap.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(defhydra hydra-kmacro (nil nil)
  "Kbd Macro:   "
  ("b" kmacro-start-macro-or-insert-counter "begin defining kbd macro")
  ("e" kmacro-end-or-call-macro "end defining or call last kbd macro")
  ("s" kmacro-name-last-macro "save last macro")
  ("q" nil "quit" :color blue))
(global-set-key (kbd "C-z k") 'hydra-kmacro/body)


(require 'bookmark)

(defhydra hydra-bookmark (nil nil)
  "bookmark  "
  ("m" bookmark-set "mark" :color blue)
  ("j" bookmark-jump "jump" :color blue)
  ("l" bookmark-bmenu-list "list")
  ("x" bookmark-delete "delete")
  ("r" bookmark-rename "rename")
  ("q" nil "quit" :color blue))
(global-set-key (kbd "C-z m") 'hydra-bookmark/body)

(defhydra hydra-bookmark-bmenu (nil nil)
  "bookmark-bmenu"
  ("o" bookmark-bmenu-otoher-window "open bookmark" :color blue)
  ("r" bookmark-bmenu-rename "rename bookmark" :color blue)
  ("x" bookmark-bmenu-delete "delete bookmark" :color blue)
  ("m" bookmark-bmenu-mark  "mark bookmark" )
  ("a" bookmark-bmenu-show-annotation "show annotation" :color blue)
  ("e" bookmark-bmenu-edit-annotation "edit annotation" :color blue)
  ("q" nil "quit" :color blue))

(keymap-set bookmark-bmenu-mode-map
    "C-z m" 'hydra-bookmark-bmenu/body)

(defhydra hydra-bookmark-edit-annotation (nil nil)
  "bookmark-bmenu"
  ("s" bookmark-edit-annotation-confirm "save annotation" :color blue)
  ("c" bookmark-edit-annotation-cancel "cancel change" :color blue)
  ("q" nil "quit" :color blue))

(keymap-set bookmark-edit-annotation-mode-map
	    "C-z m" 'hydra-bookmark-edit-annotation/body)

(use-package bookmark-frecency
  :ensure t
  :hook
  (bookmark-bmenu-mode-hook . bookmark-frecency-mode))

(provide 'init-keymap-hydra)

;;; init-keymap-hydra.el ends here

