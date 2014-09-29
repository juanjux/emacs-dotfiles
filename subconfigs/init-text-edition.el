;; my coding style, bsd but with 4 spaces indentation (and no tab
;; characters, only spaces)
    (setq-default c-basic-offset 4 c-default-style "bsd")
    (setq-default tab-width 4 indent-tabs-mode nil)
    (setq-default highlight-tabs t)

;; Auto indent lines after pressing return so I don't have to press TAB
    (define-key global-map (kbd "RET") 'newline-and-indent)

;; remove whitespace before saving
    (add-hook 'before-save-hook 'delete-trailing-whitespace)

;; dont wrap lines
    (setq-default truncate-lines t)

;; show indent guides ;; DISABLED for the moment, enabled when needed
    (require-package 'indent-guide)
    (setq indent-guide-recursive nil)
    ;; (indent-guide-global-mode)

;; guess indentation settings from buffers
    (require-package 'dtrt-indent)
    (dtrt-indent-mode 1)

;; show function names
    (which-function-mode t)

;; always turn on auto-fill/word-wrap in text-mode and set
;; the fill-column for several languages
    (add-hook 'text-mode-hook (lambda ()
                                (turn-on-auto-fill)
                                (set-fill-column 82)))
    (add-hook 'markdown-mode-hook (lambda ()
                                (turn-on-auto-fill)
                                (set-fill-column 82)))

    (add-hook 'python-mode-hook (lambda ()
                                  (set-fill-column 90)))
    (add-hook 'c-mode-hook (lambda ()
                             (set-fill-column 94)))

    (add-hook 'd-mode-hook (lambda ()
                             (set-fill-column 94)))

;; show matching parens
    (show-paren-mode t)

;; ace-jump jumps across windows
    (setq ace-jump-mode-scope 'visible)

;; more text-editing settings
    (setq
        sentence-end-double-space nil
        mark-ring-max 64
        global-mark-ring-max 128
        save-interprogram-paste-before-kill t
    )

;; function to reformat json (python required)
    (defun json-format ()
      (interactive)
      (save-excursion
        (shell-command-on-region
         (mark) (point) "python -m json.tool" (buffer-name) t)))


;; init autopair
    ;; (require-package 'autopair)
    ;; (autopair-global-mode)
    ;; (require 'smartparens-config)
    ;; (smartparens-global-mode t)

(provide 'init-text-edition)
