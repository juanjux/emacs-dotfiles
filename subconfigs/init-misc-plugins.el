;; Auto guess dictionary package
    (require-package 'auto-dictionary)
    (add-hook 'flyspell-mode-hook (lambda ()
                                    (auto-dictionary-mode t)))

;; only one dired buffer
    (require-package 'dired-single)

;; fiplr ignore
    (setq fiplr-ignored-globs '((directories (".git" ".svn" "single_emails" "/home/juanjux"))
                (files ("*.jpg" "*.png" "*.zip" "*~" "*/single_emails/*"))))

;; powerline-evil and modeline
    (require-package 'powerline)
    (powerline-evil-vim-color-theme)
    (display-time-mode t)

;; project-explorer
    (require-package 'project-explorer)
    (after 'project-explorer
      (setq pe/cache-directory "~/.emacs.d/cache/project_explorer")
      (setq pe/omit-regex (concat pe/omit-regex "\\|single_emails")))

(provide 'init-misc-plugins)
