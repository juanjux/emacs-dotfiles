(require 'evil)
(evil-mode t)
(global-evil-tabs-mode t) ; tabs (requires evil-tabs)
(require-package 'evil-jumper) ; c-i / c-o
(require-package 'evil-visualstar)
(require-package 'evil-indent-textobject)
(require-package 'evil-surround)
(require-package 'evil-matchit) ; matchit (show matching parenthesis)
(require-package 'evil-search-highlight-persist)

(global-evil-matchit-mode t)
(global-evil-surround-mode t)
(global-evil-search-highlight-persist t)
(global-evil-leader-mode t)
(setq evil-leader/in-all-states t) ; leader

;; DEL in insert mode to go 10 lines up, RET 10 down
;; From: http://stackoverflow.com/questions/8483182/evil-mode-best-practice
(define-key evil-normal-state-map (kbd "DEL") (lambda ()
                                                (interactive)
                                                (previous-line 10)
                                                (evil-scroll-line-up 10)
                                                ))

(define-key evil-normal-state-map (kbd "RET") (lambda ()
                                                (interactive)
                                                (next-line 10)
                                                (evil-scroll-line-down 10)
                                                ))

;; evil settings
(setq evil-ex-substitute-global t ; like Vim's "set gdefault"
      evil-move-cursor-back nil ; dont move back one position after exiting insert mode
      evil-jumper-auto-center t
      evil-jumper-file  "~/.emacs.d/cache/evil-jumps"
      evil-jumper-auto-save-interval 3600
      evil-emacs-state-cursor '("red" box)
      evil-normal-state-cursor '("green" box)
      evil-visual-state-cursor '("orange" box)
      evil-insert-state-cursor '("red" bar)
      evil-replace-state-cursor '("red" bar)
      evil-operator-state-cursor '("red" hollow))

;; terminal colors by mode also on console
(defun my-evil-terminal-cursor-change ()
  (when (string= (getenv "TERM_PROGRAM") "iTerm.app")
    (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\e]50;CursorShape=1\x7")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\e]50;CursorShape=0\x7"))))
  (when (and (getenv "TMUX") (string= (getenv "TERM_PROGRAM") "iTerm.app"))
    (add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=1\x7\e\\")))
    (add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=0\x7\e\\")))))

(add-hook 'after-make-frame-functions (lambda (frame) (my-evil-terminal-cursor-change)))
(my-evil-terminal-cursor-change)


;; recenter after search
(defadvice
  isearch-forward
  (after isearch-forward-recenter activate)
  (recenter))
(ad-activate 'isearch-forward)

(defadvice
  isearch-repeat-forward
  (after isearch-repeat-forward-recenter activate)
  (recenter))
(ad-activate 'isearch-repeat-forward)

(defadvice
  isearch-repeat-backward
  (after isearch-repeat-backward-recenter activate)
  (recenter))
(ad-activate 'isearch-repeat-backward)

;; ex-mode commands
;; Normal map
(defun vimlike-quit ()
  "Vimlike ':q' behavior: close current window if there are split windows;
    otherwise, close current tab (elscreen)."
  (interactive)
  (let ((one-elscreen (elscreen-one-screen-p))
        (one-window (one-window-p))
        )
    (cond
                                        ; if current tab has split windows in it, close the current live window
     ((not one-window)
      (delete-window) ; delete the current window
      (balance-windows) ; balance remaining windows
      nil)
                                        ; if there are multiple elscreens (tabs), close the current elscreen
     ((not one-elscreen)
      (elscreen-kill)
      nil)
                                        ; if there is only one elscreen, just try to quit (calling elscreen-kill
                                        ; will not work, because elscreen-kill fails if there is only one
                                        ; elscreen)
     (one-elscreen
      (evil-quit)
      nil)
     )))

(defun vimlike-write-quit ()
  "Vimlike ':wq' behavior: write then close..."
  (interactive)
  (save-buffer)
  (vimlike-quit))

(evil-ex-define-cmd "q" 'vimlike-quit)
(evil-ex-define-cmd "wq" 'vimlike-write-quit)

;; non-leader shortcuts for making vim mode more bearable on a spanish
;; keyboard
(define-key evil-normal-state-map "-" 'evil-search-forward)
(define-key evil-normal-state-map "ñ" 'evil-ex)
(define-key evil-normal-state-map "  " 'helm-my-buffers)
(define-key evil-normal-state-map " b" 'helm-bookmarks)
(define-key evil-normal-state-map " r" 'helm-recentf)
(define-key evil-normal-state-map " k" 'helm-show-kill-ring)
(define-key evil-normal-state-map " o" 'helm-occur)
(define-key evil-insert-state-map "º" 'evil-normal-state)

;; window move
(define-key evil-normal-state-map (kbd "C-w <up>") 'windmove-up)
(define-key evil-normal-state-map (kbd "C-w <down>") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-w <right>") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-w <left>") 'windmove-left)

;; elscreen kill
(define-key evil-normal-state-map (kbd "C-w d") 'elscreen-kill)

; c-number switch to elscreen (tab) (I also have <leader>-number which I prefer, but these
; binding are useful in modes where the leader doesnt work)
(define-key evil-normal-state-map (kbd "C-0") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-normal-state-map (kbd "C-º") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-normal-state-map (kbd "C-1") (lambda() (interactive) (elscreen-goto 1)))
(define-key evil-normal-state-map (kbd "C-2") (lambda() (interactive) (elscreen-goto 2)))
(define-key evil-normal-state-map (kbd "C-3") (lambda() (interactive) (elscreen-goto 3)))
(define-key evil-normal-state-map (kbd "C-4") (lambda() (interactive) (elscreen-goto 4)))
(define-key evil-normal-state-map (kbd "C-5") (lambda() (interactive) (elscreen-goto 5)))
(define-key evil-normal-state-map (kbd "C-6") (lambda() (interactive) (elscreen-goto 6)))
(define-key evil-normal-state-map (kbd "C-7") (lambda() (interactive) (elscreen-goto 7)))
(define-key evil-normal-state-map (kbd "C-8") (lambda() (interactive) (elscreen-goto 8)))
(define-key evil-normal-state-map (kbd "C-9") (lambda() (interactive) (elscreen-goto 9)))
(define-key evil-insert-state-map (kbd "C-0") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-insert-state-map (kbd "C-º") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-insert-state-map (kbd "C-1") (lambda() (interactive) (elscreen-goto 1)))
(define-key evil-insert-state-map (kbd "C-2") (lambda() (interactive) (elscreen-goto 2)))
(define-key evil-insert-state-map (kbd "C-3") (lambda() (interactive) (elscreen-goto 3)))
(define-key evil-insert-state-map (kbd "C-4") (lambda() (interactive) (elscreen-goto 4)))
(define-key evil-insert-state-map (kbd "C-5") (lambda() (interactive) (elscreen-goto 5)))
(define-key evil-insert-state-map (kbd "C-6") (lambda() (interactive) (elscreen-goto 6)))
(define-key evil-insert-state-map (kbd "C-7") (lambda() (interactive) (elscreen-goto 7)))
(define-key evil-insert-state-map (kbd "C-8") (lambda() (interactive) (elscreen-goto 8)))
(define-key evil-insert-state-map (kbd "C-9") (lambda() (interactive) (elscreen-goto 9)))

;; c-j / c-k page down/up
(define-key evil-normal-state-map (kbd "C-k") (lambda ()
                                                (interactive)
                                                (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "C-j") (lambda ()
                                                (interactive)
                                                (evil-scroll-down nil)))

;; c+ c- to increase/decrease number like Vim's C-a C-x
(define-key evil-normal-state-map (kbd "C-+") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C--") 'evil-numbers/dec-at-pt)

;; other shortcuts (prefixed by leader, which is comma here)
(evil-leader/set-leader ",")
(evil-leader/set-key "SPC" 'lazy-highlight-cleanup)
(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all)
(evil-leader/set-key "ea" 'flycheck-list-errors)   ; <leader>ea show all errors
(evil-leader/set-key "en" 'flycheck-next-error)    ; <leader>en next errors
(evil-leader/set-key "f" 'end-of-defun)            ; <leader>f/F end/start of function
(evil-leader/set-key "F" 'beginning-of-defun)
(evil-leader/set-key "gof" 'open-explorer-path)    ; open explorer window of buffer path
(evil-leader/set-key "," 'evil-ace-jump-word-mode) ; <leader>, for Ace Jump (word)
(evil-leader/set-key "l" 'evil-ace-jump-line-mode) ; <leader>l for Ace Jump (line)
(evil-leader/set-key "x" 'evil-ace-jump-char-mode) ; <leader>x for Ace Jump (char)
(evil-leader/set-key "tn" 'elscreen-create)        ; <leader>tn create new tab
(evil-leader/set-key "tc" 'elscreen-kill)          ; <leader>tc close tab
(evil-leader/set-key "gs" 'desktop-save)
(evil-leader/set-key "css" 'desktop-read)
(evil-leader/set-key "cv" 'delete-other-windows)   ; <leader>cv to close other splits
(evil-leader/set-key "im" 'helm-imenu)             ; shows functions
(evil-leader/set-key "co" 'evilnc-comment-or-uncomment-lines) ; nerd commenter
(evil-leader/set-key "m" 'emmet-expand-line) ; emmet
(evil-leader/set-key "=" (lambda(begin end)        ; <leader>= align selection lines by "="
                           (interactive "r")
                           (align-regexp begin end "\\(\\s-*\\)=" 1 1 )))
(evil-leader/set-key "v" (lambda () (interactive)
                           (split-window-horizontally)
                           (evil-window-right 1)))
(evil-leader/set-key "p" (lambda()                 ; paste on a new line below current
                           (interactive)
                           (evil-open-below 1)
                           (evil-paste-after 1)
                           (evil-normal-state)))
(evil-leader/set-key "P" (lambda()                 ; paste on a new line below current
                           (interactive)
                           (evil-open-above 1)
                           (evil-previous-visual-line 1)
                           (evil-paste-after 1)
                           (evil-normal-state)))
(evil-leader/set-key "o" (lambda () ; <leader>o open line below
                           (interactive)
                           (evil-open-below 1)
                           (evil-normal-state)))
(evil-leader/set-key "O" (lambda () ; <leader>o open line below
                           (interactive)
                           (evil-open-above 1)
                           (evil-normal-state)))
(evil-leader/set-key "ct" 'delete-trailing-whitespace)

                                        ; shortcuts for jumping to a tab
(evil-leader/set-key "0" (lambda() (interactive) (elscreen-goto 0)))
(evil-leader/set-key "1" (lambda() (interactive) (elscreen-goto 1)))
(evil-leader/set-key "2" (lambda() (interactive) (elscreen-goto 2)))
(evil-leader/set-key "3" (lambda() (interactive) (elscreen-goto 3)))
(evil-leader/set-key "4" (lambda() (interactive) (elscreen-goto 4)))
(evil-leader/set-key "5" (lambda() (interactive) (elscreen-goto 5)))
(evil-leader/set-key "6" (lambda() (interactive) (elscreen-goto 6)))
(evil-leader/set-key "7" (lambda() (interactive) (elscreen-goto 7)))
(evil-leader/set-key "8" (lambda() (interactive) (elscreen-goto 8)))
(evil-leader/set-key "9" (lambda() (interactive) (elscreen-goto 9)))

;; nerd commenter (,co)
(evil-leader/set-key "co" 'evilnc-comment-or-uncomment-lines)

;; emmet (,m)
(evil-leader/set-key "m" 'emmet-expand-line)

;; j and k move the visual line in long wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; esc quits!
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
    In Delete Selection mode, if the mark is active, just deactivate it;
    then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; save when exiting insert mode
   ;; (defun my-save-if-bufferfilename ()
   ;;   (if (buffer-file-name)
   ;;       (progn
   ;;         (save-buffer)
   ;;         )
   ;;     (message "no file is associated to this buffer: do nothing")
   ;;     )
   ;; )
   ;; (add-hook 'evil-insert-state-exit-hook 'my-save-if-bufferfilename)



(provide 'init-evil)
