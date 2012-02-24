(defun x11mode()
  "Check if we are using graphical version of emacs"
  (and (boundp 'window-system) window-system))
