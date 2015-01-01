(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)

(setq org-log-done t)
(setq org-agenda-files (list "~/org/decisiv.org" "~/org/personal.org"))
