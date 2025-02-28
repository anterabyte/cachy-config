;; ███████╗███╗   ███╗ █████╗  ██████╗███████╗
;; ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
;; █████╗  ██╔████╔██║███████║██║     ███████╗
;; ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
;; ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;; ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
                                           


;; Package management with use-package
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Save backup file in ~/.Trash
(setq backup-directory-alist '((".*" . "~/.Trash")))

;; Remove some noisy elements and add some new ones 😛
(scroll-bar-mode 0)
(display-battery-mode 1)
(display-time-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; Set Fonts
(set-face-attribute 'default nil :family "Fira Code Retina" :height 122)
(set-face-attribute 'variable-pitch nil :font "Fira Code Retina" :height 108)
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 108)

;; Line numbers
(global-display-line-numbers-mode 1)
(column-number-mode 1)
;; Disable line number for some mode
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook
		dired-mode-hook
		term-mode-hook
		vterm-mode-hook
		vterm-toggle-mode-hook
		neotree-mode-hook
		eww-mode-hook
		))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Transparency
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; key-bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "s-f") 'toggle-frame-fullscreen)

;; load theme
(load-theme 'deeper-blue)

;; Spacious Padding Mode
(use-package spacious-padding
  :init
  (spacious-padding-mode t)
  )

;; Complete the parenthesis
(use-package smartparens
  :hook (prog-mode . smartparens-mode))

;; Different color for different parenthesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Use-command-completion-and-description-package
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
        ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1)
  )


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-switch-buffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)
  )


(use-package ivy-rich
  :init
  (ivy-rich-mode t)
  )


(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package which-key
  :init
  (which-key-mode t)
  )
;; File-tree-manager
(use-package neotree
  :bind (
	 ("C-x M-t" . neotree-toggle)
	 )
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 40
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action 
        neo-theme (if (display-graphic-p) 'icons )
	)
  )

;; LSP MODE

(define-prefix-command 'eglot-lsp)
(define-prefix-command 'emacs-buffer)
(define-prefix-command 'list-themes)
(define-prefix-command 'windows)
(global-set-key (kbd "C-c l") 'eglot-lsp)
(global-set-key (kbd "C-c e") 'emacs-buffer)
(global-set-key (kbd "C-c t") 'list-themes)
(global-set-key (kbd "C-c w") 'windows)

(use-package eglot
  :diminish
  :bind (
	 :map eglot-lsp
	      ("a" . eglot-code-actions)
	      ("e" . eglot)
	 )
  )

;; Packages for programming-modes
(use-package python-mode
  :hook (python-mode . eglot-ensure))

(use-package go-mode
  :hook (go-mode . eglot-ensure))

(use-package emacs
  :bind(
	:map emacs-buffer
	     ("v" . eval-buffer)
	     ("q" . revert-buffer-quick)
	     ("k" . kill-buffer)
	:map list-themes
	     ("t" . counsel-load-theme)
	:map windows
	     ("h" . split-window-below)
	     ("d" . delete-window)
	     ("x" . delete-other-windows)
	     ("v" . split-window-right)
	     ("o" . other-window)
	)
  )

(use-package vterm)

