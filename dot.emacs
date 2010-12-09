(add-to-list 'load-path "~/.emacs.d/modes")

; turn off menubar
(menu-bar-mode 0)

; show region currently marked
(transient-mark-mode t)

; load ruby mode
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby" t)
(setq auto-mode-alist (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".rhtml$" . html-mode) auto-mode-alist))

; load compile mode, for smarter compiling (ie, for ruby)
(autoload 'mode-compile "mode-compile" "Copile based on major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile" "Kill a compile by compile-mode" t)
(global-set-key "\C-ck" 'mode-compile-kill)

; load modes for editing dotfile repo
;   zsh
(setq auto-mode-alist (cons '(".rhtml$" . html-mode) auto-mode-alist))
(autoload 'shell-script-node "shell-script-mode" "Major mode for editing shellscript" t)
(setq auto-mode-alist (cons '("dot.zshrc$" . shell-script-mode) auto-mode-alist))
;   emacs
(autoload 'emacs-lisp-mode "emacs-lisp-mode" "Major mode for editing emacs/lisp" t)
(setq auto-mode-alist (cons '("dot.emacs$" . emacs-lisp-mode) auto-mode-alist))