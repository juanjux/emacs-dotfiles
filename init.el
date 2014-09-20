(setq user-full-name "Juanjo Alvarez Martinez")
(setq user-mail-address "juanjo@juanjoalvarez.net")

(add-to-list 'load-path (expand-file-name "subconfigs" user-emacs-directory))
(require 'init-packages)
(require 'init-server)
(require 'init-colors)
(require 'init-persistence)
(require 'init-interface)
(require 'init-text-edition)
(require 'init-i18n)
(require 'init-helm)
(require 'init-autocomplete)
(require 'init-flycheck)
(require 'init-d)
(require 'init-evil)
(require 'init-tags)
(require 'init-nonevil-bindings)
(require 'init-misc-plugins)

;; some more settings
(setq
      delete-by-moving-to-trash t
      create-lockfiles nil
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("e35ef4f72931a774769da2b0c863e11d94e60a9ad97fb9734e8b28c7ee40f49b" "1e194b1010c026b1401146e24a85e4b7c545276845fc38b8c4b371c8338172ad" "2642fdd168904cc1faefcaa05e609c99095114367b1adbf41fb023291cbd7b87" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "2fc4f51bcdef89bc7a1b1da7cd9300410b25ea4c1b297c2ce1b308405ffba269" "55fc0d8437cf18c1cfdc35fb6e07c6a3041e5afc8c0988e7bf8298a41a627423" "88e3e15d0a7e039f0515428b71362c25ce36d6a19d5fe1f0c9c11b7f3557f51b" "e6d83e70d2955e374e821e6785cd661ec363091edf56a463d0018dc49fbc92dd" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "25f330cb050c7e7ec402af1b60243e8185a7837b455af0fa026593d4f48a78b2" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "2b5aa66b7d5be41b18cc67f3286ae664134b95ccc4a86c9339c886dfd736132d" "b1fdbb009af22a58788857cc5d44a4835a38088492ff0f3fea40857338cf0c3b" "7fbb8d064286706fb1e319c9d3c0a8eafc2efe6b19380aae9734c228b05350ae" "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "bd115791a5ac6058164193164fd1245ac9dc97207783eae036f0bfc9ad9670e0" default)))
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(line-number-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "M+ 1mn" :foundry "unknown" :slant normal :weight normal :height 112 :width normal)))))

(put 'narrow-to-region 'disabled nil)

(provide 'init)
