(use-package hydra
  :ensure t)

(defhydra hydra-smartparens (:hint nil)
    "
 Moving^^^^                       Slurp & Barf^^   Wrapping^^            Sexp juggling^^^^               Destructive
------------------------------------------------------------------------------------------------------------------------
 [_a_] beginning  [_n_] down      [_h_] bw slurp   [_R_]   rewrap        [_S_] split   [_t_] transpose   [_c_] change inner  [_w_] copy
 [_e_] end        [_N_] bw down   [_H_] bw barf    [_u_]   unwrap        [_s_] splice  [_A_] absorb      [_C_] change outer
 [_f_] forward    [_p_] up        [_l_] slurp      [_U_]   bw unwrap     [_r_] raise   [_E_] emit        [_k_] kill          [_g_] quit
 [_b_] backward   [_P_] bw up     [_L_] barf       [_(__{__[_] wrap (){}[]   [_j_] join    [_o_] convolute   [_K_] bw kill       [_q_] quit"
    ;; Moving
    ("a" sp-beginning-of-sexp)
    ("e" sp-end-of-sexp)
    ("f" sp-forward-sexp)
    ("b" sp-backward-sexp)
    ("n" sp-down-sexp)
    ("N" sp-backward-down-sexp)
    ("p" sp-up-sexp)
    ("P" sp-backward-up-sexp)
    ;; Slurping & barfing
    ("h" sp-backward-slurp-sexp)
    ("H" sp-backward-barf-sexp)
    ("l" sp-forward-slurp-sexp)
    ("L" sp-forward-barf-sexp)
    ;; Wrapping
    ("R" sp-rewrap-sexp)
    ("u" sp-unwrap-sexp)
    ("U" sp-backward-unwrap-sexp)
    ("(" sp-wrap-round)
    ("{" sp-wrap-curly)
    ("[" sp-wrap-square)
    ;; Sexp juggling
    ("S" sp-split-sexp)
    ("s" sp-splice-sexp)
    ("r" sp-raise-sexp)
    ("j" sp-join-sexp)
    ("t" sp-transpose-sexp)
    ("A" sp-absorb-sexp)
    ("E" sp-emit-sexp)
    ("o" sp-convolute-sexp)
    ;; Destructive editing
    ("c" sp-change-inner :exit t)
    ("C" sp-change-enclosing :exit t)
    ("k" sp-kill-sexp)
    ("K" sp-backward-kill-sexp)
    ("w" sp-copy-sexp)
    ("q" nil)
    ("g" nil))

(define-key prog-mode-map (kbd "C-c s") 'hydra-smartparens/body)

;; hydra for project.el
(defhydra hydra-project (:hint nil)
  "
       PROJECT: %(project-root (project-current t))

 [_!_] shell command                   [_b_] switch to buffer  [_v_] vc dir        [_p_] swtich project
 [_&_] async shell command             [_s_] shell             [_c_] compile       [_g_] find regexp
 [_f_] find file                       [_d_] find dir          [_e_] eshell        [_G_] project or external find regexp
 [_F_] project or external find file   [_D_] project dired     [_k_] kill buffer   [_r_] query replace regex
 [_x_] execute extended command        [_o_] any command       [_l_] list buffers

 "
  ;; Moving
  ("!" project-shell-command)
  ("&" project-async-shell-command)
  ("f" project-find-file)
  ("F" project-or-external-find-file)
  ("b" project-switch-to-buffer)
  ("s" project-shell)
  ("d" project-find-dir)
  ("D" project-dired)
  ("v" project-vc-dir)
  ("c" project-compile)
  ("e" project-eshell)
  ("k" project-kill-buffers)
  ("p" project-switch-project)
  ("g" project-find-regexp)
  ("G" project-or-external-find-regexp)
  ("r" project-query-replace-regexp)
  ("x" project-execute-extended-command)
  ("o" project-any-command)
  ("l" project-list-buffers)
  ("q"   nil "cancel" :color blue))

(define-key global-map (kbd "C-c p") 'hydra-project/body)


(provide 'init-hydra)
