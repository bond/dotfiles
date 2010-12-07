(add-to-list 'load-path "~/.emacs.d/modes")

; turn off menubar
(menu-bar-mode 0)

; load ruby mode
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby" t)
(setq auto-mode-alist (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".rhtml$" . html-mode) auto-mode-alist))
