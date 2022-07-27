(require 'init-ivy)

(setq tab-always-indent 'complete)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-selection-default nil)
  ;; (use-package company-quickhelp
  ;;   :ensure t
  ;;   :init
  ;;   (add-hook 'after-init-hook 'company-quickhelp-mode))
  :bind (("M-C-/" . 'company-complete)
	 :map company-mode-map
	 ("M-/" . 'company-complete)
	 ([remap completion-at-point] . 'company-complete)
	 ([remap indent-for-tab-command] . 'company-indent-or-complete-common)
	 :map company-active-map
	 ("C-n" . 'company-select-next)
	 ;; ("<return>" . 'my/complete-selection)
	 ;; ("RET" . 'my/complete-selection)
	 ("C-p" . 'company-select-previous)
	 ("C-d" . 'company-show-doc-buffer)
	 ("M-." . 'company-show-location)))

;; cancel company session if there is no active selection so that enter will not
;; always pick the first candidate
(defun my/cancel-complete-on-no-selection ()
  (unless company-selection
    (company-cancel)))

(advice-add 'company-complete-selection :after 'my/cancel-complete-on-no-selection)

(defun bb-company-capf (f &rest args)
  "Manage `completion-styles'."
  (if (length< company-prefix 2)
      (let ((completion-styles (remq 'fussy completion-styles)))
        (apply f args))
    (apply f args)))

(defun bb-company-transformers (f &rest args)
  "Manage `company-transformers'."
  (if (length< company-prefix 2)
      (apply f args)
    (let ((company-transformers '(fussy-company-sort-by-completion-score)))
      (apply f args))))

(advice-add 'company--transform-candidates :around 'bb-company-transformers)
(advice-add 'company-capf :around 'bb-company-capf)


(provide 'init-company)

