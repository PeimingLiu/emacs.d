(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (
	 (c-mode . lsp)
	 (c++-mode . lsp)))

(use-package company-lsp
  :ensure t
  :commands company-lsp)

(provide 'init-lsp)
  


