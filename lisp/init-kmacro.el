;;; init-keymap.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(defun init-kmacro-vim-normal-kmacro (cmd-sequence)
  "CMD-SEQUENCE."
  (concat "a " cmd-sequence " <escape>"))

(defalias 'm-kmacro
   (kmacro (init-kmacro-vim-normal-kmacro "1 2 3")))


(provide 'init-kmacro)

;;; init-kmacro.el ends here

