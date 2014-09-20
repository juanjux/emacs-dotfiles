;; start emacs-server if not running
    (if (fboundp 'with-eval-after-load)
        (defmacro after (feature &rest body)
          "After FEATURE is loaded, evaluate BODY."
          (declare (indent defun))
          `(with-eval-after-load ,feature ,@body))
      (defmacro after (feature &rest body)
        "After FEATURE is loaded, evaluate BODY."
        (declare (indent defun))
        `(eval-after-load ,feature
           '(progn ,@body))))

    (add-hook 'after-init-hook
              (lambda ()
                (require 'server)
                (unless (server-running-p)
                  (server-start))))

(provide 'init-server)
