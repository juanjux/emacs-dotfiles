;; start emacs-server if not running
(provide 'init-server)
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))
