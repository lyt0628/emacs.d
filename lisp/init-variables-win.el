


(defconst lyt-note-directory "d:/org"  "My Org note dir")

(require 'bookmark)
(setq bookmark-default-file
	(expand-file-name "bookmark-win.el" lyt-emacs-directory))




;; Config form Windows ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq w32-pass-rwindow-to-system nil) ; block right window icon key
(setq w32-pass-lwindow-to-system nil) ; block left window icon key
(setq w32-lwindow-modifier 'super) ; rebind win to super
(w32-register-hot-key [s-])

(setq w32-scroll-lock-modifier 'super)

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'hyper) ; Menu key

