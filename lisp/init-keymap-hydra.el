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


  
(defhydra hydra-bookmark (nil nil)
  "bookmark  "
  ("m" bookmark-set "mark" :color blue)
  ("j" bookmark-jump "jump" :color blue)
  ("l" bookmark-bmenu-list "list")
  ("x" bookmark-delete "delete")
  ("q" nil "quit" :color blue))
(global-set-key (kbd "C-z m") 'hydra-bookmark/body)



(provide 'init-keymap-hydra)

;;; init-keymap-hydra.el ends here

