;; create backup files on a directory inside dotemacs
    (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Remember last edit positions
    (require-package 'saveplace)
    (setq save-place-file "~/.emacs.d/saveplace")
    (setq-default save-place t)

;; minibuffer history
    (require-package 'savehist)
    (setq savehist-file "~/.emacs.d/savehist"
          savehist-additional-variables '(search ring regexp-search-ring)
          savehist-autosave-interval 60)
    (setq-default history-length 1000)
    (savehist-mode +1)

;; bookmarks
    (setq bookmark-default-file "~/.emacs.d/bookmarks"
          bookmark-save-flag 1) ;; save after every change


;; lots of recent files
    (require 'recentf)
    (setq recentf-save-file "~/.emacs.d/recentf"
          recentf-max-saved-items 1000
          recentf-max-menu-items 500)
    (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
    (recentf-mode +1)
    (run-with-timer 1800 1800 'recentf-save-list)

;; Functions to save and buffers+tabs (elscreens) sessions, source:
;; http://stackoverflow.com/questions/22445670/save-and-restore-elscreen-tabs-and-split-frames
;; http://stackoverflow.com/questions/803812/emacs-reopen-buffers-from-last-session-on-startup
    (defvar emacs-configuration-directory
      "~/.emacs.d/"
      "The directory where the emacs configuration files are stored.")
    (defvar elscreen-tab-configuration-store-filename
      (concat emacs-configuration-directory ".elscreen")
      "The file where the elscreen tab configuration is stored.")

    (defun session-save ()
      "Store the elscreen tab configuration."
      (interactive)
      (if (desktop-save emacs-configuration-directory)
          (with-temp-file elscreen-tab-configuration-store-filename
            (insert (prin1-to-string (elscreen-get-screen-to-name-alist))))))

    (defun session-load ()
      "Restore the elscreen tab configuration."
      (interactive)
      (if (desktop-read)
          (let ((screens (reverse
                          (read
                           (with-temp-buffer
                             (insert-file-contents
                              elscreen-tab-configuration-store-filename)
                             (buffer-string))))))
            (while screens
              (setq screen (car (car screens)))
              (setq buffers (split-string (cdr (car screens)) ":"))
              (if (eq screen 0)
                  (switch-to-buffer (car buffers))
                (elscreen-find-and-goto-by-buffer (car buffers) t t))
              (while (cdr buffers)
                (switch-to-buffer-other-window (car (cdr buffers)))
                (setq buffers (cdr buffers)))
              (setq screens (cdr screens))))))


(provide 'init-persistence)
