;; init theme

;; (use-package zenburn-theme)

(setq custom-safe-themes t)

(use-package color-theme-sanityinc-solarized
  :ensure t)
(use-package color-theme-sanityinc-tomorrow
  :ensure t)

;; default theme
(add-hook 'after-init-hook 'color-theme-sanityinc-tomorrow-night)

(provide 'init-themes)


    
