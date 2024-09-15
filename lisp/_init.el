;;; _init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
;; (require '_init)
(let ((min_ver "27.1"))
  (when (version< emacs-version min_ver)
    (error "Your Emacs is too old -- this config requires v%s or higher" min_ver)))
(when (version< emacs-version "28.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(when (string= system-type "windows-nt")
  (add-to-list 'load-path "e:/emacs.d/lisp"))

(when (string= system-type "gnu/linux")
  (add-to-list 'load-path "~/data/emacs.d/lisp"))

(require 'init-util)

(lyt-util-add-remote-package-repository
 "melpa-orgin"  "https://melpa.org/packages/")

(lyt-util-add-remote-package-repository
 "marmalade-origin"  "http://marmalade-repo.org/packages/")

(package-initialize)

;(package-refresh-contents)




(require 'init-variables)


(require 'init-behavior)

(require 'init-keymap)

;(require 'init-kmacro)

(eval-when-compile (require 'use-package))

(require 'init-face)


(require 'init-org)


(require 'init-basic)

(require 'init-keymap-hydra)

(require 'init-prog)


(require 'init-clojure)

(require 'init-lua)


(provide '_init)


;;; _init.el ends here
