(use-package company
  :ensure t
  :commands global-company-mode
  :init
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.0) ;; default is 0.2
  (add-hook 'after-init-hook 'global-company-mode)
  :bind
  (
   :map company-mode-map
   ("M-/" . 'company-complete)
   :map company-active-map
   ("M-/" . 'company-other-backend)
   ("C-n" . 'company-select-next) ;; change the keybinding
   ("C-p" . 'company-select-previous)))

(provide 'init-company)
