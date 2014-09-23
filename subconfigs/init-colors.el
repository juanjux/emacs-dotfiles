;; My current
    ;; (load-theme 'ample-zen t)
    (load-theme 'professional t)

;; color-theme-aproximate to fix colors in console mode
    (color-theme-approximate-on)

;; Colors-Identifiers-Mode to colorize variable names
    (require-package 'diminish)
    (require-package 'color-identifiers-mode)
    (global-color-identifiers-mode)
    (diminish 'color-identifiers-mode)

;; rainbox-delimiters
    (require-package 'rainbow-delimiters)
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; highlight current line
    (global-hl-line-mode)

(provide 'init-colors)
