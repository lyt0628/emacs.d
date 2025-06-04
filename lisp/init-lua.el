
(use-package reformatter :ensure t)

(require 'reformatter)

(use-package lua-mode :ensure t
  :after reformatter
  :config
  (reformatter-define lua-format
  :program "lua-format"
  :args '("--indent-width=2" "--no-use-tab")
  :lighter "LuaFmt ")
  :custom
  (lua-indent-line  2))

(provide 'init-lua)
