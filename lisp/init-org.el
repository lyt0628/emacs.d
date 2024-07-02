;;; init-org.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
;;; -*- lexical-binding: t -*-

(require 'cl-lib)
(require 'org)

(require 'init-util)



(defconst lyt-note-directory
  (expand-file-name "note/" user-emacs-directory))

;(use-package org-download
;  :ensure t
;  :hook
;  (dired-mode org-download-enable)
;  :config
;  (setq org-download-image-dir (expand-file-name "assets/" lyt-note-directory))


(use-package uuidgen :ensure t)

(use-package ob-rust :ensure t)
(use-package ob-latex-as-png :ensure t)
(use-package ob-go :ensure t)
(use-package ob-elixir :ensure t)
(org-babel-do-load-languages
  'org-babel-load-languages
      '((js                  . t)
	(shell               . t)
	(python              . t)
	(C                   . t)
	(go                  . t)
	(elixir              . t)
	(lua                 . t)
	(emacs-lisp          . t)
	(perl                . t)
	(clojure             . t)
	(ruby                . t)
	(rust                . t)
	(sql                 . t)
	(awk                 . t)
	(css                 . t)
	(prolog              . t)
	(html-chrome         . t)
	(dot                 . t)
	(latex-as-png        . t)
	(plantuml            . t)))


(defconst org-plantuml-jar-path
  "~/data/emacs.d/bin/plantuml-lgpl-1.2024.3.jar")



(define-derived-mode dot-mode graphviz-dot-mode "Skynet"
  "Major mode for editing dot code."
  :group 'graphviz-dot)




(use-package org-download
  :ensure t
  :config
  (require 'org-download)
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq org-download-image-dir "lyt-note-directory/images"))



(require 'init-roam)






(provide 'init-org)


;;; init-org.el ends here

