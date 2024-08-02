;;; init-keymap.el<.emacs.d> --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


(unbind-key "C-q"); 没人会花时间去手打非打印字符
(unbind-key "C-y")
(unbind-key "C-d")
(unbind-key "C-z") ; and not want to syspend Emacs

(unbind-key "<f3>") ; kmacro-start-macro-or-insert-counter
(unbind-key "<f4>") ; kmacro-end-or-call-macro


(unbind-key "C-j" ) ; electric-newline-and-mybe-index

(unbind-key "C-k") ; kill-line
(unbind-key "C-x o") ; other-window

(provide 'init-keymap-reset)


;;; init-keymap-reset.el ends here

