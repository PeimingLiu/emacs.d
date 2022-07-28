(add-to-list 'load-path (expand-file-name "theme" user-emacs-directory))

;; add theme path into load path
(let ((theme-path (expand-file-name "theme" user-emacs-directory)))
  (dolist (sub-path (directory-files theme-path nil directory-files-no-dot-files-regexp))
    (let ((abs-path (expand-file-name sub-path theme-path)))
      (if (file-directory-p abs-path)
          (add-to-list 'load-path abs-path)))))

(require 'lambda-themes)
(load-theme 'lambda-dark)

(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)

(global-hl-line-mode)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 20))

(use-package beacon
  :ensure t
  :hook
  (after-init-hook . beacon-mode)
  :config
  (setq-default beacon-lighter "")
  (setq-default beacon-size 20))

;; indent line
;; (use-package highlight-indent-guides
;;   :ensure t
;;   :config
;;   (setq highlight-indent-guides-method 'character)
;;   (setq highlight-indent-guides-responsive 'top)
;;   :hook (prog-mode . highlight-indent-guides-mode))

(use-package rainbow-mode
  :ensure t
  :config
  (rainbow-turn-on))

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window)))

;; (require 'column-marker)
;; (add-hook 'prog-mode-hook (lambda () (interactive) (column-marker-1 80)))

(provide 'init-ui)
