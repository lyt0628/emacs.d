
(defconst lyt-note-directory (expand-file-name "org" "~/" ) "My Org note dir")

(require 'bookmark)
(setq bookmark-default-file
	(expand-file-name "bookmark-linux.el" lyt-emacs-directory))

