(use-package company
  :ensure t
  :commands global-company-mode
  :init
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
