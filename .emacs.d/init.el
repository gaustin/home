(set-face-attribute 'default nil :foundry "apple" :family "Anonymous_Pro")

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  )
(package-initialize)

(defvar gca-packages '(auto-complete
                       coffee-mode
                       haml-mode
                       yaml-mode
                       magit
                       rvm
                       enh-ruby-mode
                       ruby-end
                       ruby-refactor
                       rspec-mode
                       minitest
                       web-mode
                       yasnippet
                       clojure-mode
                       clojure-test-mode
                       cider
                       paredit
                       hl-line+
                       color-theme
                       smex
                       ido-vertical-mode
                       ido-better-flex)) ;; this matching is kind of insane.
(dolist (p gca-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Backup and auto-saves go to ~/.emacs.d/auto-save-list
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; General editing niceties
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t) ;; show trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; remove trailing whitespace on save

(setq column-number-mode t) ;; show column numbers
(delete-selection-mode t) ;; delete selection when typing

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward) ;; no more <n> for similarly named files

;; hide various ui elements
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(show-paren-mode t)
(electric-pair-mode t) ;; auto-insert matching parens, brackets and quotes
(global-hl-line-mode 0) ;; hl-line+ -- TODO: make the highlight prettier in terminal
(toggle-hl-line-when-idle 1)

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places")) ;; save file location

;; copy/paste
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t)

;; Finding files/buffers, etc
(ido-mode t)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-vertical-mode t)
;; TODO: ido-use-virtual-buffers?
;; TODO: ctags and find files by tag - http://www.emacswiki.org/emacs/InteractivelyDoThings#toc21
;; TODO: Helm might be great here, especially the gem searcher

(setq apropos-do-all t) ;; not sure
(global-set-key (kbd "C-x C-b") 'ibuffer) ;; better buffer list
(global-set-key (kbd "M-/") 'hippie-expand) ;; questionable expander - TODO: ctags integration? - http://www.emacswiki.org/emacs/HippieExpand

;; Find commands
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; ctags - TODO: search gems, default completion table, fancy file finder
;;(setq tags-completion-table)
;; (defun my-ido-find-tag ()
;;   "Find a tag using ido"
;;   (interactive)
;;   (tags-completion-table)
;;   (let (tag-names)
;;     (mapatoms (lambda (x)
;;                 (push (prin1-to-string x t) tag-names))
;;               tags-completion-table)
;;     (find-tag (ido-completing-read "Tag: " tag-names))))

;; (defun ido-find-file-in-tag-files ()
;;       (interactive)
;;       (save-excursion
;;         (let ((enable-recursive-minibuffers t))
;;           (visit-tags-table-buffer))
;;         (find-file
;;          (expand-file-name
;;           (ido-completing-read
;;            "Project file: " (tags-table-files) nil t)))))
;; TODO: ack

;; Setup theme
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-jsc-dark)

;;javascript
(setq js-indent-level 2) ;; indent js 2 spaces

;; Directories and file names
(setq gca-emacs-init-file (or load-file-name buffer-file-name))
(setq gca-emacs-config-dir
      (file-name-directory gca-emacs-init-file))
(setq user-emacs-directory gca-emacs-config-dir)
(setq gca-init-dir
      (expand-file-name "init.d" gca-emacs-config-dir))

;; Load all elisp files in ./init.d
(if (file-exists-p gca-init-dir)
    (dolist (file (directory-files gca-init-dir t "\\.el$"))
      (load file)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-variable-name-face ((t (:foreground "light salmon" :weight bold))))) ;; Prevent '|' in foo.each { |bar| puts bar } from appearing like front slashes.
