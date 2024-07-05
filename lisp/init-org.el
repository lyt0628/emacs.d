;;; init-org.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
;;; -*- lexical-binding: t -*-

(require 'cl-lib)
(require 'org)

(require 'init-util)


(defconst lyt-note-directory "~/data/emacs.d/org")


(require 'init-org-keymap)

(require 'init-org-babel)

(use-package org-download
  :ensure t
  :config
  (require 'org-download)
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq org-download-image-dir "lyt-note-directory/images"))



(require 'init-package-roam)


(provide 'init-org)


;;; init-org.el ends here

