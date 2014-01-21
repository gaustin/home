;; Initialize package repos
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  )
(package-initialize)

(defvar gca-packages '(color-theme
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

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places")) ;; save file location

;; copy/paste
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t)

;; Finding files/buffers, etc
(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-vertical-mode t)
;; TODO: ido-use-virtual-buffers?
;; TODO: ctags and find files by tag - http://www.emacswiki.org/emacs/InteractivelyDoThings#toc21

(setq apropos-do-all t) ;; not sure
(global-set-key (kbd "C-x C-b") 'ibuffer) ;; better buffer list
(global-set-key (kbd "M-/") 'hippie-expand) ;; questionable expander - TODO: ctags integration? - http://www.emacswiki.org/emacs/HippieExpand

;; Setup theme
(require 'color-theme) ;; would not install with package-install here. *shrug*
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
