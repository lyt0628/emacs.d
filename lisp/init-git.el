

(use-package git-modes :ensure nil)

(use-package git-timemachine :ensure nil)

(use-package git-link :ensure nil)


(use-package magit :ensure t
  :config
   (setq-default magit-diff-refine-hunk 'all))


(provide 'init-git)
