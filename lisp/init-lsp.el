;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.1))

;; TODO: filter out cider lsp
(defun pl/maybe-format-buffer ()
  (if (lsp-feature? "textDocument/formatting")
      (lsp-format-buffer)))

(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode . lsp-deferred)
	 (c++-mode . lsp-deferred)
	 ;; if you want which-key integration
	 (lsp-mode . lsp-enable-which-key-integration))

  :commands (lsp lsp-deferred)
  :config
  (setq gc-cons-threshold 100000000)
  (setq lsp-eldoc-enable-hover nil)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (add-hook 'before-save-hook #'pl/maybe-format-buffer)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
                    :major-modes '(c-mode c++-mode)
                    :remote? t
                    :server-id 'clangd-remote)))



(use-package yasnippet
  :ensure t
  :after lsp-mode
  :config
  (add-hook 'lsp-mode-hook #'yas-minor-mode))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-position 'at-point)
  ;; TODO: maybe use color from theme
  (set-face-background 'lsp-ui-doc-background "black")
  (set-face-background 'lsp-ui-peek-footer "black")
  (set-face-background 'lsp-ui-peek-header "black")
  (set-face-foreground 'lsp-ui-peek-line-number "white")
  (lsp-ui-peek-enable +1)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

;; (use-package dap-mode
;;   :ensure t
;;   :defer
;;   :custom
;;   (dap-auto-configure-mode t                           "Automatically configure dap.")
;;   (dap-auto-configure-features
;;    '(sessions locals breakpoints expressions tooltip)  "Remove the button panel in the top.")
;;   :config
;;   ;;; dap for c++
;;   ;;; (require 'dap-lldb)

;;   ;;; set the debugger executable (c++)
;;   ;;; (setq dap-lldb-debug-program '("/usr/bin/lldb-vscode"))


;;   ;;; ask user for executable to debug if not specified explicitly (c++)
;;   (setq dap-lldb-debugged-program-function (lambda () (read-file-name "Select file to debug."))))

;; (use-package lsp-ivy
;;   :ensure t)

;; (use-package all-the-icons
;;   :if (display-graphic-p))

;; TODO: for lsp-treemacs
(use-package treemacs
  :ensure t
  :config
  (global-set-key (kbd "M-t") #'treemacs-select-window)
  (global-set-key (kbd "s-t") #'treemacs))

(use-package lsp-treemacs
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)


(provide 'init-lsp)
