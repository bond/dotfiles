; Variables
(defvar emacshome "~/.emacs.d")

; init
(add-to-list 'load-path (concat emacshome "/modes"))
(add-to-list 'load-path (concat emacshome "/themes"))
(add-to-list 'load-path (concat emacshome "/extensions"))
(load "functions")

;#########################################
;##
;## LOOK AND FEEL
;##
;#########################################

; disable stuff
(setq inhibit-splash-screen t) ; the splash-screen splits x11 mode
(setq inhibit-startup-message t) ; welcome screen
(setq vc-follow-symlinks t) ; Don't ask me about symlinks in version controlled files
(put 'upcase-region 'disabled nil) ; I never mean to use this function anyway

; I allways close emacs when I don't want it
(defun ask-before-closing ()
  "Close if user answers y"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit? "))
      (if (< emacs-major-version 22)
	  (save-buffers-kill-terminal)
	(save-buffers-kill-emacs))
    (message "Cancelled exit")))

; Perform setup for x11 and console
(if (x11mode)
    (progn ; x11mode
      (global-set-key (kbd "C-x C-c") 'ask-before-closing)
      (set-face-attribute 'default nil :font "Ubuntu Mono 15")
      (setq x-select-enable-clipboard t) ; as above
      (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))
  (menu-bar-mode 0)); not x11mode

; Visual settings
(transient-mark-mode t) ;show region currently marked

(global-font-lock-mode t) ; turn on colors

; use marmalade for emacs24
(setq has-packages nil)
(when (require 'package nil 'noerror)
  (if 'noerror
    (progn
	(setq has-packages t)
	(add-to-list 'package-archives
		     '("marmalade" . "http://marmalade-repo.org/packages/"))
	(package-initialize))))


; Install packages (requires marmalade)
(if has-packages 
    (progn
      ; theme
      (install-pkg 'twilight-theme)
      (require 'twilight-theme)

      ; puppet
      (install-pkg '(puppet-mode))
      (add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))))

      ; clojure
      (install-pkg '(clojure-mode nrepl))
      (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode) ;enable eldoc
      (setq nrepl-popup-stacktraces nil)
      (add-to-list 'same-window-buffer-names "*nrepl*") ; make C-c C-z switch to *nrepl* buffer

      ; php
      (install-pkg 'php-mode)
      (autoload 'phpmode "php-mode" "Majore mode for editing PHP" t)
      (add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
      (add-hook 'php-mode-hook
		'(lambda ()
		   (outline-minor-mode 0)))


; tab configuration
(setq c-basic-offset 2)
(setq indent-tabs-mode nil)
(setq tab-width 2)

(cua-mode t); enable c-S-x, c-S-v, c-S-c for copy/paste

; global shortcuts
(global-set-key (kbd "M-1") 'kill-whole-line)
(global-set-key (kbd "C-d") 'delete-region)
(global-set-key (kbd "M-2") 'goto-line)

; enable disabled-stuff
(put 'erase-buffer 'disabled nil)

;#########################################
;##
;## UNDER THE HOOD
;##
;#########################################

; remote editing
(setq tramp-default-method "ssh")

; save backups in temporary directory in .emacs.d

(let ((tmpd (concat emacshome "/tmp"))
      (backupd (concat emacshome "/backup")))
  (if (file-accessible-directory-p emacshome)
      (progn
	(unless (file-accessible-directory-p backupd)(make-directory backupd))
	(setq backup-directory-alist
	      `((".*" . ,backupd)))

	(unless (file-accessible-directory-p tmpd)(make-directory tmpd))
	(setq auto-save-file-name-transforms
	      `((".*" ,tmpd t)))
	)
    )
  )

; Convenience function to chmod current buffer
(defun chmod-buffer (mode)
  "Function that sets the chmod of the current buffer (file)"
  (interactive "sEnter file mode: ")
  (let (file))
    (progn
      (setq file (buffer-file-name))
      (unless file (error "Buffer must be a valid file"))
      (set-file-modes file (string-to-number mode 8))))


; Bookmark settings
(setq
 bookmark-default-file "~/.emacs.d/bookmarks" ;; Keep my ~/ clean
 bookmark-save-flag 1                         ;; Autosave changes
)


;#########################################
;##
;## MODES AND SETTINGS
;##
;#########################################

; setup for drupal coding standards
(require 'drupal-mode)
(add-to-list 'auto-mode-alist '("\\.\\(module\\|test\\|\\|theme\\)$" . drupal-mode))

; load ruby mode
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml$" . ruby-mode))

; load Lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode" t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))

; load compile mode, for smarter compiling (ie, for ruby)
(autoload 'mode-compile "mode-compile" "Copile based on major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile" "Kill a compile by compile-mode" t)
(global-set-key "\C-ck" 'mode-compile-kill)

; load modes for editing dotfile repo
;   zsh
(add-to-list 'auto-mode-alist '("dot.zshrc$" . shell-script-mode))
;   emacs
(add-to-list 'auto-mode-alist '("dot.emacs$" . emacs-lisp-mode))

; load support for org-mode
(add-to-list 'auto-mode-alist '(".org$" . org-mode))
