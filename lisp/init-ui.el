;;(require 'hl-line+)

;;(global-linum-mode 1)
;;(global-hl-line-mode t)
;;(toggle-hl-line-when-idle)

(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(global-hl-line-mode)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; theme
;; (use-package kaolin-themes
;;   :ensure t
;;   :config
;;   (load-theme 'kaolin-light t)
;;   ;; (if (display-graphic-p)
;;   ;;     (load-theme 'kaolin-light t)
;;   ;;   (load-theme 'kaolin-dark t))
;;   )
;; (setq debug-on-error t)

;; (use-package auto-dim-other-buffers
;;   :ensure t
;;   :init
;;   (add-hook 'after-init-hook (lambda () (progn
;; 					  (auto-dim-other-buffers-mode 1))))
;;   :config
;;   (if (display-graphic-p)
;;     (custom-set-faces
;;        '(auto-dim-other-buffers-face ((t (:background "gray97"))))
;;        '(auto-dim-other-buffers-hide-face ((t (:background "gray97" :foreground "gray97"))))))
;;   (custom-set-faces
;;    '(auto-dim-other-buffers-face ((t (:background "color-235"))))
;;    '(auto-dim-other-buffers-hide-face ((t (:background "color-235" :foregound "color235")))))
;;   )

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (if (display-graphic-p)
      (color-theme-sanityinc-tomorrow-day)
    (color-theme-sanityinc-tomorrow-night)))

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

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window)))

;; (require 'column-marker)
;; (add-hook 'prog-mode-hook (lambda () (interactive) (column-marker-1 80)))

(provide 'init-ui)
