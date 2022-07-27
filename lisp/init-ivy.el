(use-package ivy
  :ensure t
  :config
  ;;(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (define-key ivy-minibuffer-map (kbd "RET") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
  (add-hook 'after-init-hook 'ivy-mode))

(use-package swiper
  :ensure t
  :bind
  ("C-s" . 'swiper)
  ("C-r" . 'swiper-backward))

(use-package counsel
  :ensure t
  :bind
  (("C-x C-f" . 'counsel-find-file)
   ("M-x" . 'counsel-M-x)
   ("C-h f" . 'counsel-describe-function)
   ("C-h v" . 'counsel-describe-variable))
  :config
  ;; direct to file without exit completion
  (define-key counsel-ag-map (kbd "TAB") 'ivy-call))


(use-package fussy
  :ensure t
  :config
  (push 'fussy completion-styles)
  (setq
   ;; For example, project-find-file uses 'project-files which uses
   ;; substring completion by default. Set to nil to make sure it's using
   ;; flx.
   completion-category-defaults nil
   completion-category-overrides nil))

;; see https://github.com/jojojames/fussy#ivy-integration
(defun ivy--fussy-sort (name cands)
  "Sort according to closeness to string NAME the string list CANDS."
  (condition-case nil
      (let* ((bolp (= (string-to-char name) ?^))
             ;; An optimized regex for fuzzy matching
             ;; "abcv" → "^[^a]*a[^b]*b[^c]*c"
             (fuzzy-regex (concat "\\`"
                                  (and bolp (regexp-quote (substring name 1 2)))
                                  (mapconcat
                                   (lambda (x)
                                     (setq x (char-to-string x))
                                     (concat "[^" x "]*" (regexp-quote x)))
                                   (if bolp (substring name 2) name)
                                   "")))
             ;; Strip off the leading "^" for flx matching
             (flx-name (if bolp (substring name 1) name))
             cands-left
             cands-to-sort)
        ;; Filter out non-matching candidates
        (dolist (cand cands)
          (when (string-match-p fuzzy-regex cand)
            (push cand cands-left)))

        ;; pre-sort the candidates by length before partitioning
        (setq cands-left (cl-sort cands-left #'< :key #'length))

        ;; partition the candidates into sorted and unsorted groups
        (dotimes (_ (min (length cands-left) ivy-flx-limit))
          (push (pop cands-left) cands-to-sort))

        (nconc
         ;; Compute all of the flx scores in one pass and sort
         (mapcar #'car
                 (sort (mapcar
                        (lambda (cand)
                          (cons cand
                                (car
                                 (funcall
                                  fussy-score-fn
                                  cand flx-name
                                  ivy--flx-cache))))
                        cands-to-sort)
                       (lambda (c1 c2)
                         ;; Break ties by length
                         (if (/= (cdr c1) (cdr c2))
                             (> (cdr c1)
                                (cdr c2))
                           (< (length (car c1))
                              (length (car c2)))))))
         ;; Add the unsorted candidates
         cands-left))
    (error cands)))

(advice-add 'ivy--flx-sort :override 'ivy--fussy-sort)

(provide 'init-ivy)
