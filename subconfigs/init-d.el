;; fix for compile to find the errors with DMD
    (require 'compile)
    (add-to-list
     'compilation-error-regexp-alist
     '("^\\([^ \n]+\\)(\\([0-9]+\\)): \\(?:error\\|.\\|warnin\\(g\\)\\|remar\\(k\\)\\)"
       1 2 nil (3 . 4)))

;; ac-dcd (auto completion for Dlang)
    (require-package 'ac-dcd)
    (add-hook 'd-mode-hook 'ac-dcd-setup)
    (setq ac-dcd-flags (quote ("-I/usr/include/dmd"
                               "-I~/wodri/backend/source"
                               "-I~/wodri/backend/source/webbackend/source"
                               "-I~/wodri/backend/source/libs"
                               "-I~/.dub/packages/vibe-d-master/source")))

    (setq flycheck-dmd-include-path '("/usr/include/dmd"
                                      "~/wodri/backend/source"
                                      "~/wodri/backend/source/webbackend/source"
                                      "~/wodri/backend/source/libs"
                                      "~/.dub/packages/vibe-d-master/source"))

    (add-hook 'd-mode-hook 'flycheck-dmd-dub-set-include-path)

;; dtags
;; no dtags, just use: use C-c . && C-c , to jump from / to symbol in D

(provide 'init-d)
