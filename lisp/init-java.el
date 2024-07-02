;;; init-org.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:
(require 'cl-lib)
(require 'org)


(require 'init-util)




;; org-babel

(org-babel-do-load-languages
  'org-babel-load-languages
      '((java                . t)))



(require 'ob-java)
(let ((library-files (mapconcat 'identity
				(lyt-util-list-files-in-dir
				 "~/data/emacs.d/lib/java"
				 "jar")
				":")))
  (nconc org-babel-default-header-args:java
	 `((:dir . "workdir")
	   (:cmpflag . ,(concat "-cp " library-files))
	   (:cmdline . ,(concat "-cp .:"  library-files)))))






(provide 'init-java)



;;; init-java.el ends here
