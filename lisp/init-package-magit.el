;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(use-package magit
  :ensure t
  :hydra (hydra-magit ()
		      ""
		      ("c" magit-clone "git clone")
		      ("q" nil "quit")))


(global-set-key (kbd "s-g") 'hydra-magit/body)



(provide 'init-package-magit)
;;; init-package-magit.el ends here
