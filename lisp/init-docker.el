(use-package exec-path-from-shell
  :ensure t
  :init
  (when (or (memq window-system '(mac ns x)) (daemonp))
    (exec-path-from-shell-initialize)))

(use-package docker-tramp
  :ensure t
  :init
  (setq docker-tramp-docker-executable "docker"))

(provide 'init-docker)
