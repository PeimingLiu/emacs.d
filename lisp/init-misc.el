(defun sanityinc/maybe-suspend-frame ()
  (interactive)
  (unless (and *is-a-mac* window-system)
    (suspend-frame)))

(global-set-key (kbd "C-z") 'sanityinc/maybe-suspend-frame)
;; switch cut and copy
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "M-w") 'kill-region)

(defun undo-or-comment ()
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (undo)))

(global-set-key (kbd "C-/") 'undo-or-comment)

(setq-default cursor-type 'bar)

;; multi-cursor support
(use-package multiple-cursors
  :ensure t
  :config
  (setq mc/match-cursor-style nil)
  ;;;###autoload
  (defun mc/mark-all-like-this-after ()
    "Find and mark all the parts of the buffer matching the currently active region"
    (interactive)
    (unless (region-active-p)
      (error "Mark a region to match first."))
    (mc/remove-fake-cursors)
    (let ((master (point))
          (case-fold-search nil)
          (point-first (< (point) (mark)))
          (re (regexp-opt (mc/region-strings) mc/enclose-search-term)))
      (mc/save-excursion
       ;; (goto-char 0)
       (while (search-forward-regexp re nil t)
         (push-mark (match-beginning 0))
         (when point-first (exchange-point-and-mark))
         (unless (= master (point))
           (mc/create-fake-cursor-at-point))
         (when point-first (exchange-point-and-mark)))))
    (if (> (mc/num-cursors) 1)
        (multiple-cursors-mode 1)
      (mc/disable-multiple-cursors-mode)))
  :bind
  (("C-M-p" . 'mc/mark-previous-like-this)
   ("C-M-n" . 'mc/mark-next-like-this)
   ("C-M-m" . 'mc/edit-lines)))



;; (use-package centered-window :ensure t
;;   :config
;;   (centered-window-mode t))

(provide 'init-misc)
