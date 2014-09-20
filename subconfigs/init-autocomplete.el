(require-package 'auto-complete)
(require 'auto-complete-config)
    (setq ac-auto-show-menu t
          ac-auto-start t
          ac-quick-help-delay 0.3
          ac-quick-help-height 30
          ac-show-menu-immediately-on-auto-complete t)
    (ac-config-default)

    (after 'yasnippet
      (add-hook 'yas-before-expand-snippet-hook (lambda () (auto-complete-mode -1)))
      (add-hook 'yas-after-exit-snippet-hook (lambda () (auto-complete-mode t)))
      (defadvice ac-expand (before advice-for-ac-expand activate)
        (when (yas-expand)
          (ac-stop))))

(provide 'init-autocomplete)
