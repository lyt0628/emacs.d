;;; init-org.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
;;; -*- lexical-binding: t -*-

(require 'cl-lib)
(require 'org)

(require 'init-variables)

(defconst lyt-note-directory
  (expand-file-name "org" lyt-emacs-directory))


(require 'init-org-keymap)

(require 'init-ob)

(require 'init-org-roam)

(use-package org-download
  :ensure t
  :config
  (require 'org-download)
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq org-download-image-dir "lyt-note-directory/images"))





(provide 'init-org)


;;; init-org.el ends here

