(defun x11mode()
  "Check if we are using graphical version of emacs"
  (and (boundp 'window-system) window-system))

(defun install-pkg (package-list)
  "Installs a single package by symbol, or list of symbols"
  (if (listp package-list)
      (dolist (p package-list)
	(install-ifnot-installed p))
    (install-ifnot-installed package-list)))

(defun install-ifnot-installed (package)
  "Install a package or require it from marmalade"
  (unless (package-installed-p package)
    (package-install package)))
