;;--------------------------
;; utilities for open files
;;--------------------------
(defun open-configuration-file ()
  (interactive)
  (let ((full-name nil)
	(file-name (read-string "Open configuration file: ")))
    (if (string= file-name "init")
	  (setq full-name (expand-file-name "init.el" user-emacs-directory))
      ;; else
      (setq full-name
	    (concat
	     (expand-file-name file-name 
			       (expand-file-name "lisp" user-emacs-directory))
	     ".el")))
    (if (file-exists-p full-name)
	(find-file full-name)
      ;; else
      (if (yes-or-no-p
	       (format "lisp/%s.el does not exist, create it?" file-name))
	(find-file full-name)))))

(provide 'init-utils)
