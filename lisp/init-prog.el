;;; init-prog.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 
;;; Code:


;; Yasnipper teplate system ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun _/backend-with-yas (backend)
  "Add company-yasnippet as company BACKEND ."
  (if (and (listp backend) ; type check
	   (member 'company-yasnippet backend)) ; avoid re-enter
      backend
    (append (if (consp backend) ; type check
		backend
	      (list backend))
            '(:with company-yasnippet))))

;; Yasnipper is a tempalte system for Emacs.
(use-package yasnippet
  :custom
  (yas-snippet-dirs lyt-yas-dirs)
  :config
  (yas-global-mode)
  (setq company-backends
  	(mapcar #'_/backend-with-yas company-backends))

;; snippets community collects.
(use-package yasnippet-snippets  :ensure t)



;; FlyCheck checks for errors in code at run-time.
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  :custom
  (truncate-lines nil))



; Projectile helps us with easy navigation within a project.
;Projectile recognizes several source control managed folders e.g *git, mercurial, maven, sbt*, and a folder with empty *.projectile* file.
;You can use ~C-c p~ to invoke any projectile command. This is a very useful key to remember.
(use-package projectile
  :ensure t
  :bind (("C-c p" . projectile-command-map))
  :init (projectile-mode +1)
  )


(use-package counsel-projectile
  :ensure t
  :init
  (counsel-projectile-mode))

;; show tree hererichy in left dock.
(use-package treemacs
  :ensure t
  :commands (treemacs)
  :after (lsp-mode) ; we load lsp-mode in late.
  :config
  (treemacs-tag-follow-mode)
  :hydra (hydra-treemacs ()
			 "worktree: "
			 ("t" treemacs "toggle")
			 ("m" treemacs-bookmark "bookmark")
			 ("f" treemacs-find-file "find file")
			 ("t" treemacs-find-tag "find tag")
			 ("1" treemacs-delete-other-windows "delete other windows")
			 ("q" nil "quit" :color blue))
  :bind
  ("H-t" . hydra-treemacs/body)
  ("M-0"       . treemacs-select-window)
  (:map treemacs-mode-map
	("/" . treemacs-advanced-helpful-hydra)))


(use-package treemacs-projectile  :ensure t )


;; Treemacs provides UI elements used for LSP UI.
;; Let's install lsp-treemacs and its dependency treemacs.
;; We will also Assign ~M-9~ to show error list.
(use-package lsp-treemacs
  :after (lsp-mode treemacs) ; we load lsp-mode in late.
  :ensure t
  :commands lsp-treemacs-errors-list
  :bind (:map lsp-mode-map
         ("M-9" . lsp-treemacs-errors-list)))


;; quickrun can execute current code file. if it hold basic program entry
;(e.g. Main Method in Java, main method in C/Cpp and if __main__ == "main" in python)
(use-package quickrun
:ensure t
:bind ("C-c r" . quickrun))

;; magic is a friendly git interface
(use-package magit
  :ensure t
  :bind ("C-z g" . hydra-magit/body)
  :hydra (hydra-magit ()
		      ""
		      ("c" magit-clone "git clone")
		      ("m" magit-cmmit "git commit")
		      ("p" magit-push "git push")
		      ("q" nil "quit")))

;; Languge Gramar Check and Hint ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Complete anything aka Company provides auto-completion.
;;Company-capf is enabled by default when you start LSP on a project.
;;You can also invoke ~M-x company-capf~ to enable capf (completion at point function).
(use-package company
  :ensure t
  :init
  (global-company-mode)
  :custom
  (company-minimum-prefix-length 1) ; 我希望它晚点触发，为了性能考虑
  (company-tooltip-align-annotations t)
  (company-idle-delay 0.0)
  (company-show-quick-access t); 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (company-selection-wrap-around t)
  (company-tabnine-wait 0.25)
  (company-transformers '(company-sort-by-occurrence))
  ) ; 根据选择的频率进行排序

;; Make company beautiful Icon in left.
(use-package company-box
  :ensure t
  :if window-system
  :hook (company-mode . company-box-mode))

;; Ai Hint backend for company. It is very slow
;(use-package company-tabnine
;  :ensure t
;  :init
;  (add-to-list 'company-backends
;	       #'company-tabnine))



;; LSP UI is used in various packages that require UI elements in LSP.
;; E.g. ~lsp-ui-flycheck-list~ opens a windows where you can see various coding errors while you code.
;; You can use ~C-c l T~ to toggle several UI elements.
;; We have also remapped some of the xref-find functions, so that we can easily jump around between symbols using ~M-.~, ~M-,~ and ~M-?~ keys.

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)
	)
  :custom
  ((lsp-ui-doc-delay 1.5)
   (lsp-ui-doc-position 'bottom)
   (lsp-ui-doc-max-width 100)
   ))

(use-package lsp-ivy
  :ensure t
  :after (lsp-mode)
  :commands
   lsp-ivy-workspace-symbol)



(use-package dap-mode
  :ensure t
  :after (lsp-mode)
  :functions dap-hydra/nil
  :bind
  (:map lsp-mode-map
        ("<f5>" . dap-debug)
        ("M-<f5>" . dap-hydra))
  :hook (
	 (dap-mode . dap-ui-mode)
	 (dap-session-created . (lambda (&_rest) (dap-hydra)))
	 (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))
	 )
  )



;; Let's install the main package for lsp.
;; Here we will integrate lsp with which-key.
;; This way, when we type the prefix key ~C-c l~ we get additional help for completing the command.
(use-package lsp-mode
  :ensure t
  :hook (
	 (lsp-mode . lsp-enable-which-key-integration)
	 (java-mode . #'lsp-deferred)
	 (before-save-hook . lsp-format-buffer)
	 (before-save-hook . lsp-organize-imports)
	 )
  :custom (
	   (lsp-keymap-prefix "C-c l" "this is for which-key integration documentation, need to use lsp-mode-map")
	   (lsp-enable-file-watchers nil)
	   (read-process-output-max (* 1024 1024))
	   (lsp-completion-provider :capf)
	   (lsp-idle-delay 0.500)
	   (lsp-headerline-breadcrumb-enable t)
	   (lsp-intelephense-multi-root nil "don't scan unnecessary projects")
	   )
  :config
  (with-eval-after-load 'lsp-intelephense
    (setf (lsp--client-multi-root
	   (gethash 'iph lsp-clients)) nil))
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  :bind
  ("C-c l s" . lsp-ivy-workspace-symbol)
  )



;; Load language support
(require 'init-prog-java)

(require 'init-prog-c-cpp)

(provide 'init-prog)

;;; init-prog.el ends here

