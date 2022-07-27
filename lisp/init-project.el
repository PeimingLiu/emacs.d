(use-package projectile
  :ensure t
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map))
  :config
  (setq projectile-completion-system 'ivy)
  (setq compilation-scroll-output t)
  (setq projectile-compile-use-comint-mode t)
  (push "projectile.cache" projectile-globally-ignored-files)
  (setq projectile-indexing-method 'hybrid)
  ;;(setq projectile-enable-caching t)
  ;;(setq projectile-globally-ignored-file-suffixes '(".o" ".O")))
)


(use-package counsel-projectile
  :ensure t)

(advice-add 'projectile-grep :override #'counsel-projectile-grep)

(provide 'init-project)
