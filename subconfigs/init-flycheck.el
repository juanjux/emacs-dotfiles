(require-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(cond ((eq window-system 'w32)
       (setq flycheck-flake8rc "C:\\installs\\flake8rc")))

(after 'flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled)
        flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)
        flycheck-checkers (delq 'html-tidy flycheck-checkers)
        flycheck-standard-error-navigation nil))
(global-flycheck-mode t)

;; flycheck errors on a tooltip (doesnt work on console)
(when (display-graphic-p (selected-frame))
  (eval-after-load 'flycheck
    '(custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))

(provide 'init-flycheck)
