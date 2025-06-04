
  (use-package ruby-ts-mode
    :mode "\\.rb\\'"
    :mode "Rakefile\\'"
    :mode "Gemfile\\'"
    :hook (ruby-ts-mode . subword-mode)
    :custom
    (ruby-indent-level 2)
    (ruby-indent-tabs-mode nil)
    ;; Tree-sitter 
    :bind (:map ruby-ts-mode-map
                ("C-z z" . 'hydra-ts-ruby/body))
    :hydra (hydra-ts-ruby (:hint nil)
                          ""
                          ("b" treesit-beginning-of-defun "To beginning of function")
                          ("e" treesit-end-of-defun "To end of function")
                          ("q" nil "Quit")
                          )
    ;; Eglot for ruby
    :bind (:map ruby-ts-mode-map
                ("C-z x" . 'hydra-eglot-ruby/body))
    :hydra (hydra-eglot-ruby (:hint nil)
                             ""
                             ("r" eglot-rename "Rename symbol")
                             ("q" nil "Quit"))

    ) ;; End of use-package ruby-ts-mode



(provide 'init-ruby)
