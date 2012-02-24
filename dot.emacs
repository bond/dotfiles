; Variables
(defvar emacshome "~/.emacs.d")

(add-to-list 'load-path (concat emacshome "/modes"))
(add-to-list 'load-path (concat emacshome "/themes"))


;#########################################
;##
;## LOOK AND FEEL
;##
;#########################################

; disable stuff
(setq inhibit-splash-screen t) ; the splash-screen splits x11 mode
(setq inhibit-startup-message t) ; welcome screen
(put 'upcase-region 'disabled nil) ; I never mean to use this function anyway

; turn off menubar, when not using X11
(unless (and (boundp 'window-system) window-system)
  (menu-bar-mode 0))

; Visual settings
(set-face-attribute 'default nil :font "Ubuntu Mono 13") ; default font
(transient-mark-mode t) ;show region currently marked

(global-font-lock-mode t) ; turn on colors
(require 'color-theme) ; set color theme
(require 'color-theme-twilight)
(color-theme-twilight)


; tab configuration
(setq c-basic-offset 2)
(setq indent-tabs-mode nil)
(setq tab-width 2)


; global shortcuts
(global-set-key (kbd "M-1") 'kill-whole-line)
(global-set-key (kbd "C-d") 'delete-region)
(global-set-key (kbd "M-2") 'goto-line)


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

; load PHP mode
(autoload 'php-mode "php-mode" "Major mode for editing PHP" t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
; turn off outline in php-mode
(add-hook 'php-mode-hook
	  '(lambda ()
	     (outline-minor-mode 0)))
; setup for drupal coding standards
(require 'drupal-mode)
(add-to-list 'auto-mode-alist '("\\.\\(module\\|test\\|install\\|theme\\)$" . drupal-mode))

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
