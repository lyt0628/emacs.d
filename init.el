






(when (string= system-type "window-nt")
  (add-to-list 'load-path "D;/data/emacs.d/lisp"))


(when (string= system-type "gnu/linux")
  (add-to-list 'load-path "~/data/emacs.d/lisp"))


(reqire '_init.el)
