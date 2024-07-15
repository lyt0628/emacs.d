;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:



(defvar lyt-tmp-var nil)
(defvar lyt-tmp-var-1 nil)
(defvar lyt-tmp-var-2 nil)
(defvar lyt-tmp-var-3 nil)



(defconst lyt-extra-modifier-key "s")

(defconst lyt-emacs-directory "~/data/emacs.d/")



;; Overrite emacs variables

(setq custom-file
   (expand-file-name "custom.el" lyt-emacs-directory))
(load custom-file)




(provide 'init-variables)
;;; init-variables.el ends here
