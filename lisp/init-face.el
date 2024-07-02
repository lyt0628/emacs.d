;;; init-face.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:


(defconst custom-file
   (expand-file-name "custom.el" user-emacs-directory))
(setq custom-file custom-file)


(use-package all-the-icons :ensure t)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-ayu-dark t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config))




(provide 'init-face)

;;; init-face.el ends here

