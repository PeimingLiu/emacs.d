(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(debug-on-variable-change 'ignored-local-variable-values)
(set-face-attribute 'default nil :height 160)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
(menu-bar-mode -1)
(recentf-mode 1)

;; make trailing whitespace more visible
(setq show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "red")
(add-hook 'fundamental-mode-hook #'google-maybe-show-trailing-whitespace)

(setq-default frame-title-format
              '(:eval
                (format "%s@%s: %s %s"
                        (or (file-remote-p default-directory 'user)
                            user-real-login-name)
                        (or (file-remote-p default-directory 'host)
                            system-name)
                        (buffer-name)
                        (cond
                         (buffer-file-truename
                          (concat "(" buffer-file-truename ")"))
                         (dired-directory
                          (concat "{" dired-directory "}"))
                         (t
                          "[no file]")))))


(defconst *is-a-mac* (eq system-type 'darwin))
(defconst normal-gc-cons-threshold (* 20 1024 1024))
(defconst init-gc-cons-threshold   (* 128 1024 1024))

(if *is-a-mac*
    (progn
      (set-frame-parameter nil 'ns-appearance 'light)
      (set-frame-parameter nil 'ns-transparent-titlebar t)))

;; Adjust garbage collection thresholds during startup, and thereafter
(setq gc-cons-threshold init-gc-cons-threshold)
(add-hook 'after-init-hook
	  (lambda () (setq gc-cons-threshold normal-gc-cons-threshold)))

;; do not backup file
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq enable-remote-dir-locals t)
(setq-default indent-tabs-mode nil)

;; load custom file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file)

;; activate emacs when started from command line
(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))

  (defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))

  (add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)

  (when (display-graphic-p)
    (ns-raise-emacs)))

(add-hook 'after-make-frame-functions #'toggle-frame-maximized)
;;(add-hook 'after-make-frame-functions #'my/set-font)

;; allow copyed text into macOS system clipboard
(if (display-graphic-p)
    (progn
      (toggle-frame-maximized))
    (progn
      (setq xterm-tmux-extra-capabilities '(modifyOtherKeys setSelection))
      (setq xterm-extra-capabilities '(setSelection))
      (require 'mouse)
      (xterm-mouse-mode t)
      (global-set-key [mouse-4] (lambda ()
                                  (interactive)
                                  (scroll-down 1)))
      (global-set-key [mouse-5] (lambda ()
                                  (interactive)
                                  (scroll-up 1)))
      (defun track-mouse (e))
      (setq mouse-sel-mode t)))

(require 'package)

;; init elpa and use-pacakge
(require 'init-elpa)

;; init theme and ui
(require 'init-ui)

;; various settings
(require 'init-misc)

;; init company
(require 'init-company)

;; ivy
(require 'init-ivy)

;; projectile
;; (require 'init-project)

;;
(require 'init-prog)

;; (require 'init-lsp)

(require 'init-magit)

(require 'init-hydra)


;; always delete trailing whitespace before saving the file
(add-hook 'before-save-hook #'delete-trailing-whitespace)
