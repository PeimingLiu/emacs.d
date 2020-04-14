(setq auto-save-default nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; full screen on startup
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; disable redundant UI elements
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------

(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'emacs-startup-hook
	  (lambda () (setq gc-cons-threshold (* 20 1024 1024))))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))


;;----------------------------------------------------------------------------
;; Set up use-package
;;----------------------------------------------------------------------------
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; .emacs.d/lisp 
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-utils)
(require 'init-themes)
(require 'init-ivy)
(require 'init-ui)
(require 'init-company)
(require 'init-git)
(require 'init-projectile)
(require 'init-lsp)


(when (file-exists-p custom-file)
  (load custom-file))
