(require 'org)

(if (eq system-type 'windows-nt)
    (setq org-directory "C:/ilionData/Users/juanjo.alvarez/Documents/Dropbox/Org")
  (setq org-directory "~/Dropbox/Org"))

(if (eq system-type 'windows-nt)
    (setq org-mobile-directory "C:/ilionData/Users/juanjo.alvarez/Documents/Dropbox/MobileOrg")
  (setq org-mobile-directory "~/Dropbox/MobileOrg"))

(setq org-mobile-inbox-for-pull (concat org-directory "/flagged.org"))

(provide 'init-org)
