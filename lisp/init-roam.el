


(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (expand-file-name "roam" my/emacs-dir))  ; 设置 org-roam 目录
  :config
  (org-roam-db-sync)
  (org-roam-db-autosync-enable)
  :bind
  (("C-c n f" . org-roam-node-find) ; note find
   (:map org-mode-map
         (("C-c n i" . org-roam-node-insert)
          ("C-c n o" . org-id-get-create)
          ("C-c n t" . org-roam-tag-add)
          ("C-c n a" . org-roam-alias-add)
          ("C-c n l" . org-roam-buffer-toggle))))
  )


(use-package org-roam-ui
  :if (display-graphic-p)
  :after org-roam
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t))



(provide 'init-roam)
