;;; init.el --- Emacs init file
;;  Author: Iraklis karagkiozoglou
;;; Code:
(defvar file-name-handler-alist-original file-name-handler-alist)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      site-run-file nil)

;; (setq max-lisp-eval-depth 10000)
;; (setq max-specpdl-size 13000)

(defvar ik/gc-cons-threshold 100000000)

(add-hook 'emacs-startup-hook ; hook run after loading init files
          #'(lambda ()
              (setq gc-cons-threshold ik/gc-cons-threshold
                    gc-cons-percentage 0.1
                    file-name-handler-alist file-name-handler-alist-original)))
(add-hook 'minibuffer-setup-hook #'(lambda ()
                                     (setq gc-cons-threshold most-positive-fixnum)))
(add-hook 'minibuffer-exit-hook #'(lambda ()
                                    (garbage-collect)
                                    (setq gc-cons-threshold ik/gc-cons-threshold)))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;;;;  package.el
;;; so package-list-packages includes them
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;;; Default font
(defun ik/set-default-font ()
  (interactive)
  (when (member "Source Code Pro" (font-family-list))
    (set-face-attribute 'default nil :family "Source Code Pro"))
  (set-face-attribute 'default nil
                      :height 140
                      :weight 'normal))

(defvar ik/indent-buffer-exclude-list
  `(".*db/schema.rb$"))

(defun ik/indent-buffer-excluded ()
  (interactive)
  (setq-local buffer_name buffer-file-name)
  (setq-local excluded nil)
  (when (stringp buffer_name)
    (dolist (pattern ik/indent-buffer-exclude-list)
      (when (string-match pattern buffer_name)
        (setq-local excluded t))))
  excluded)

(defun ik/indent-buffer ()
  (interactive)
  (unless (ik/indent-buffer-excluded)
    (save-excursion
      (indent-region (point-min) (point-max) nil))))

(defun ik/auto-insert-indent ()
  (interactive)
  (unless (file-exists-p buffer-file-name)
    (auto-insert)
    (when yas--active-snippets
      (yas-next-field-or-maybe-expand)
      (save-excursion
        (yas-exit-all-snippets)
        (ik/indent-buffer)))))

;;; Generic settings for emacs
(defun ik/emacs ()
  ;; setup username
  (setq user-full-name "Andrew Griffith")
  ;; set window title always to emacs
  (setq frame-title-format '("Emacs"))
  ;; default directory to open emacs in
  (setq default-directory "~/src/griffithind_co")
  ;; various emacs settings
  (setq frame-resize-pixelwise t)
  (setq auto-window-vscroll nil)
  (setq load-prefer-newer t)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  ;; disable toolbar, menu, startup screen & scrollbar
  (setq inhibit-startup-screen t)
  (menu-bar-mode -1)
  (if (display-graphic-p)
      (progn
        (setq initial-frame-alist '((fullscreen . maximized)))
        (tool-bar-mode -1)
        (scroll-bar-mode -1)))
  ;; setup font
  (ik/set-default-font)
  ;; scrolling
  (setq scroll-conservatively 10000)
  (setq scroll-preserve-screen-position t)
  ;; show column
  (column-number-mode +1)
  ;; window
  (setq split-width-threshold 140)
  ;; delsel
  (delete-selection-mode +1)
  ;; backups
  (setq auto-save-default nil)
  (setq confirm-kill-processes nil)
  (setq make-backup-files nil)
  ;; autorevert
  (setq auto-revert-interval 2)
  (setq auto-revert-check-vc-info t)
  (setq global-auto-revert-non-file-buffers t)
  (setq auto-revert-verbose nil)
  (global-auto-revert-mode +1)
  ;; mousewheel
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
  (setq mouse-wheel-progressive-speed nil)
  ;; eldoc
  (setq eldoc-idle-delay 0.4)
  ;; autoinsert hook
  (setq auto-insert-query nil) ; dont ask each time
  (add-hook 'find-file-hook 'ik/auto-insert-indent)
  ;; ediff
  (setq ediff-window-setup-function #'ediff-setup-windows-plain)
  (setq ediff-split-window-function #'split-window-horizontally)
  ;; dired mode
  (setq delete-by-moving-to-trash t)
  (put 'dired-find-alternate-file 'disabled nil))

(ik/emacs)

;;; Theme
(use-package color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-eighties t)

;;; Code editing

;; define variable to be used accross mods for indent

(defvar ik/indent-width 2)

(defun ik/code-editing ()
  (setq-default line-spacing 3)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width ik/indent-width)
  ;; paren
  (setq show-paren-delay 0)
  (show-paren-mode +1)
  ;; electric pair
  (add-hook 'prog-mode-hook 'electric-pair-mode)
  ;; display line numbers
  (setq-default display-line-numbers-width 2)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (add-hook 'text-mode-hook 'display-line-numbers-mode)
  ;; cleanup whitespace
  (add-hook 'before-save-hook 'whitespace-cleanup)
  ;; when reopening a file go to the same location in the file
  (save-place-mode +1)
  ;; js
  (setq js-indent-level ik/indent-width)
  (setq-local js2-basic-offset ik/indent-width)
  ;;  cc-vars
  (setq c-default-style '((java-mode . "java")
                          (awk-mode  . "awk")
                          (other     . "k&r")))
  (setq-default c-basic-offset ik/indent-width)
  ;; python
  (setq python-indent-offset ik/indent-width)
  ;; C-tab auto formatting buffer
  (add-hook 'prog-mode-hook
            (lambda ()
              (local-set-key [C-tab] 'ik/indent-buffer)))
  ;; format buffer before save
  (add-hook 'prog-mode-hook
            (lambda ()
              (add-hook 'before-save-hook 'ik/indent-buffer nil 'local))))

(ik/code-editing)

(use-package fill-column-indicator
  :config
  ;; fill-column-indicator
  (setq-default fill-column 80)
  (add-hook 'prog-mode-hook 'fci-mode)
  (add-hook 'text-mode-hook 'fci-mode))

;; GUI enhancements
;; (use-package highlight-symbol
;;   :hook (prog-mode . highlight-symbol-mode)
;;   :config
;;   (setq highlight-symbol-idle-delay 0.3))

;; (use-package highlight-numbers
;;   :hook (prog-mode . highlight-numbers-mode))

;; (use-package highlight-operators
;;   :hook (prog-mode . highlight-operators-mode))

;; (use-package highlight-escape-sequences
;;   :hook (prog-mode . hes-mode))

;; Terminal

(use-package vterm ; when installing, evaluate exec-path first (else 'command not found')
  :hook (vterm-mode . (lambda ()
                        (setq-local global-hl-line-mode nil)
                        (setq-local line-spacing nil))))

(use-package vterm-toggle
  :after evil
  :config
  (with-eval-after-load 'evil
    (evil-set-initial-state 'vterm-mode 'emacs))
  (global-set-key (kbd "C-`") #'vterm-toggle)
  (global-set-key (kbd "s-j") #'vterm-toggle)
  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list 'display-buffer-alist
               '("^v?term.*"
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 (reusable-frames . visible)
                 (window-height . 0.5))))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Vi keybindings
(use-package evil
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil
        evil-shift-width ik/indent-width)
  :hook (after-init . evil-mode)
  :preface
  (defun ik/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
  :config
  (with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil)
    (define-key evil-normal-state-map (kbd "gd") #'xref-find-definitions))
  (defalias #'forward-evil-word#'forward-evil-symbol)
  (setq-default evil-symbol-word-search t)
  (evil-ex-define-cmd "q" 'kill-current-buffer)
  (evil-ex-define-cmd "wq" 'ik/save-and-kill-this-buffer))





(use-package evil-leader
  :config
  (evil-leader/set-leader ",")
  (global-evil-leader-mode))

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-company-use-tng nil)
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode +1))

(use-package evil-magit)

;; Git integration

(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (add-hook 'with-editor-mode-hook #'evil-insert-state))

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.1))

(if (display-graphic-p)
    (use-package git-gutter-fringe
      :config
      (progn
        (setq-default fringes-outside-margins t)
        (define-fringe-bitmap 'git-gutter-fr:added [224]
          nil nil '(center repeated))
        (define-fringe-bitmap 'git-gutter-fr:modified [224]
          nil nil '(center repeated))
        (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240]
          nil nil 'bottom))))

;; Ivy, Counsel and Swiper
(use-package ivy
  :hook (after-init . ivy-mode)
  :config
  (setq ivy-height 15)
  (setq ivy-display-style nil)
  (setq ivy-re-builders-alist
        '((counsel-rg            . ivy--regex-plus)
          (counsel-projectile-rg . ivy--regex-plus)
          (swiper                . ivy--regex-plus)
          (t                     . ivy--regex-fuzzy)))
  (setq ivy-use-virtual-buffers nil)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
  (define-key ivy-mode-map       (kbd "<escape>") nil)
  (define-key ivy-minibuffer-map (kbd "<escape>") #'minibuffer-keyboard-quit))

(use-package counsel
  :after evil
  :hook (ivy-mode . counsel-mode)
  :config
  (setq counsel-find-file-ignore-regexp
        (concat
         ;; File names beginning with # or .
         "\\(?:\\`[#.]\\)"
         ;; File names ending with # or ~
         "\\|\\(?:\\`.+?[#~]\\'\\)")))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode t))

(use-package swiper
  :after ivy
  :config
  (setq swiper-action-recenter t)
  (setq swiper-goto-start-of-match t))

(use-package ivy-rich
  :config
  (ivy-rich-mode +1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

;; Yasnippet
(use-package yasnippet
  :diminish yas-minor-mode
  :preface (defvar tmp/company-point nil)
  :config
  (yas-global-mode t)
  (advice-add 'company-complete-common
              :before
              #'(lambda ()
                  (setq tmp/company-point (point))))
  (advice-add 'company-complete-common
              :after
              #'(lambda ()
                  (when (equal tmp/company-point (point))
                    (yas-expand)))))

;; Projectile
(use-package projectile
  :config
  (setq projectile-indexing-method 'hybrid)
  (setq projectile-completion-system 'ivy)
  (define-key projectile-mode-map (kbd "C-c p") #'projectile-command-map)
  (projectile-global-mode))

(use-package projectile-rails
  :config
  (define-key projectile-rails-mode-map (kbd "C-c r") #'projectile-rails-command-map)
  (define-key projectile-rails-mode-map (kbd "C-q") #'projectile-rails-goto-file-at-point)
  (projectile-rails-global-mode))

;; Company
(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 3
        company-idle-delay 0
        company-selection-wrap-around t
        company-tooltip-align-annotations t
        company-frontends '(company-pseudo-tooltip-frontend
                            company-echo-metadata-frontend))
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "C-j") nil) ; avoid conflict with emmet-mode
    (define-key company-active-map (kbd "C-n") #'company-select-next)
    (define-key company-active-map (kbd "C-p") #'company-select-previous)))

;; Prescient
(use-package prescient
  :config
  (setq prescient-filter-method '(literal regexp initialism fuzzy))
  (prescient-persist-mode +1))

(use-package ivy-prescient
  :after (prescient ivy)
  :config
  (setq ivy-prescient-sort-commands
        '(:not swiper
               counsel-grep
               counsel-rg
               counsel-projectile-rg
               ivy-switch-buffer
               counsel-switch-buffer))
  (setq ivy-prescient-retain-classic-highlighting t)
  (ivy-prescient-mode +1))

(use-package company-prescient
  :after (prescient company)
  :config
  (company-prescient-mode +1))

(use-package company-posframe
  :config
  (setq
   company-posframe-show-indicator nil
   company-posframe-quickhelp-delay nil
   company-posframe-mode +1))

;; Programming language support and utilities
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode +1)
  (setq which-key-idle-delay 0.4
        which-key-idle-secondary-delay 0.4))

;; markdown
(use-package markdown-mode)

;; web dev
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'"   . web-mode)
         ("\\.jsx?\\'"  . web-mode)
         ("\\.tsx?\\'"  . web-mode)
         ("\\.json\\'"  . web-mode))
  :config
  (setq web-mode-markup-indent-offset ik/indent-width)
  (setq web-mode-code-indent-offset ik/indent-width)
  (setq web-mode-css-indent-offset ik/indent-width)
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))

;; yaml
(use-package yaml-mode
  :mode "\\.yml\\'")

;; slim
(use-package slim-mode
  :mode "\\.slim\\'")

;; coffee
(use-package coffee-mode
  :mode "\\.coffee\\'")

;; ruby
(use-package enh-ruby-mode
  :mode (("Rakefile\\'" . enh-ruby-mode)
         ("rb\\'" . enh-ruby-mode)))

(use-package ruby-electric)
(use-package ruby-interpolation)
(use-package ruby-end)

(use-package robe
  :config
  (add-hook 'enh-ruby-mode-hook 'robe-mode))

;; (use-package polymode)

;; (use-package poly-ruby
;;   :config
;;   (add-hook 'enh-ruby-mode-hook 'poly-enh-ruby-mode))

;; sql

(use-package sqlup-mode
  :config
  (add-hook 'sql-mode-hook 'sqlup-mode)
  (add-hook 'sql-mode-hook
            (lambda ()
              (add-hook
               'before-save-hook
               'sqlup-capitalize-keywords-in-buffer nil 'LOCAL))))

(use-package sql-indent
  :config
  (defvar my-sql-indentation-offsets-alist
    `((select-clause 0)
      (insert-clause 0)
      (delete-clause 0)
      (update-clause 0)
      (with-clause-cte 0)
      (with-clause-cte-cont +)
      (select-table-continuation 0)
      (select-join-condition +)
      ,@sqlind-default-indentation-offsets-alist))
  (add-hook 'sqlind-minor-mode-hook
            (lambda ()
              (setq sqlind-indentation-offsets-alist
                    my-sql-indentation-offsets-alist)))
  (add-hook 'sql-mode-hook 'sqlind-minor-mode))

(defun evil/keybinding ()
  (evil-leader/set-key "q" 'projectile-rails-goto-file-at-point)
  (evil-leader/set-key "f" 'ik/indent-buffer)
  (evil-leader/set-key "e" 'find-file)
  (evil-leader/set-key "b" 'switch-to-buffer)
  (evil-leader/set-key "d" 'delete-window)
  (evil-leader/set-key "x" 'counsel-M-x)
  (evil-leader/set-key "g" 'counsel-grep-or-swiper)
  (evil-leader/set-key "v" 'split-window-right)
  (evil-leader/set-key "s" 'split-window-vertically)
  (evil-leader/set-key "m" 'other-window)
  (evil-leader/set-key "c" 'comment-dwim)
  (evil-leader/set-key "t" 'projectile-find-file)
  (evil-leader/set-key "y" 'vterm-toggle)
  (evil-leader/set-key "r" 'projectile-rails-command-map)
  (evil-leader/set-key "a" 'counsel-projectile-rg))

(evil/keybinding)

(provide 'init)
;;; init.el ends here
