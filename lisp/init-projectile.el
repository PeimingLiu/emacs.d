;; for projectile-ag
(use-package ag
  :ensure t)

(use-package projectile
  :ensure t
  :commands projectile-mode
  :init
  (setq projectile-completion-system 'ivy)
  :config
  :bind
  (
   :map projectile-mode-map
	("C-c p" . 'projectile-command-map)))

(use-package counsel-projectile
  :ensure t
  :init
  (add-hook 'after-init-hook #'counsel-projectile-mode))
  


;; make the name shorter
(setq-default projectile-mode-line-prefix " Proj")
(provide 'init-projectile)
