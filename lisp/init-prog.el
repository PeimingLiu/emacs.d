(use-package tree-sitter
  :ensure t)

(use-package tree-sitter-langs
  :ensure t)

(use-package eterm-256color
  :ensure t
  :hook (term-mode . eterm-256color-mode))

(use-package cmake-mode
  :ensure t)

(use-package hl-todo
  :ensure t
  :hook (prog-mode . hl-todo-mode))

;; get MLIR/LLVM MODE from llvm git repo
;; (el-get-bundle mlir
;;   :url "https://raw.githubusercontent.com/llvm/llvm-project/main/mlir/utils/emacs/mlir-mode.el")
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(add-hook 'show-paren-mode #'prog-mode)

;; smart parenthesis
(use-package smartparens-config
  :ensure smartparens
  :config (sp-use-smartparens-bindings)
  :hook (prog-mode . smartparens-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)
  :config
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(rainbow-delimiters-depth-1-face ((t (:foreground "#9B2226"))))
   '(rainbow-delimiters-depth-2-face ((t (:foreground "#ae2012"))))
   '(rainbow-delimiters-depth-3-face ((t (:foreground "#bb3e03"))))
   '(rainbow-delimiters-depth-4-face ((t (:foreground "#ca6702"))))
   '(rainbow-delimiters-depth-5-face ((t (:foreground "#ee9b00"))))
   '(rainbow-delimiters-depth-6-face ((t (:foreground "#e9d8a6"))))
   '(rainbow-delimiters-depth-7-face ((t (:foreground "#94d2bd"))))
   '(rainbow-delimiters-depth-8-face ((t (:foreground "#0a9396"))))))

(provide 'init-prog)
