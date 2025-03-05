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
(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(display-battery-mode 1)
(display-time-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; Set Fonts
(set-face-attribute 'default nil :family "Fira Code Retina" :height 130)
(set-face-attribute 'variable-pitch nil :font "Fira Code Retina" :height 108)
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 108)

;; Line numbers
(global-display-line-numbers-mode 1)
(column-number-mode 1)
;; Disable line number for some mode
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook
		dirvish-mode-hook
		dired-mode-hook
		term-mode-hook
		vterm-mode-hook
		vterm-toggle-mode-hook
		neotree-mode-hook
		eww-mode-hook
		gptel-mode-hook
		))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Transparency
(add-to-list 'default-frame-alist '(alpha-background . 90))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                      KEY-BINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; SETUP some prefix for some actions
(define-prefix-command 'eglot-lsp)
(define-prefix-command 'emacs-buffer)
(define-prefix-command 'list-themes)
(define-prefix-command 'windows)
(define-prefix-command 'neotree)
(define-prefix-command 'consult)

;; Advance keybindings
(global-set-key (kbd "C-c l") 'eglot-lsp)
(global-set-key (kbd "C-c e") 'emacs-buffer)
(global-set-key (kbd "C-c t") 'list-themes)
(global-set-key (kbd "C-c w") 'windows)
(global-set-key (kbd "C-c n") 'neotree)
(global-set-key (kbd "C-c c") 'consult)

;; Basic key-bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "s-f") 'toggle-frame-fullscreen)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                     UI-UX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package doom-themes
  ;; load themes
  :ensure t
  :config
  (load-theme 'doom-snazzy t)
  )

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                         FILE-MANAGER                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package neotree
  :bind (
	 :map neotree
	      ("t" . neotree-toggle)
	      ("n" . neotree-create-node)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                  LSP AND PROGRAMMING MODES                                                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; LSP MODE and PROGRAMMING MODES

(use-package eglot
  :diminish
  :bind (
	 :map eglot-lsp
	      ("a" . eglot-code-actions)
	      ("e" . eglot)
	 )
  )

(use-package company
  :init (global-company-mode 1)
  :hook (prog-mode . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))


;; Packages for programming-modes
(use-package python-mode
  :hook (python-mode . eglot-ensure))

(use-package go-mode
  :hook (go-mode . eglot-ensure))

(use-package yaml-mode
  :mode "\\.y?ml\\'"
  :hook (yaml-mode . eglot-ensure)
  )

(use-package emacs
  :bind(
	:map emacs-buffer
	     ("v" . eval-buffer)
	     ("q" . revert-buffer-quick)
	     ("k" . kill-buffer)
	     ("b" . counsel-switch-buffer)
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

(use-package consult

  :bind(
	:map consult
	     ("f" . consult-flymake)
	)
  )

(use-package vterm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            PROJECT.EL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'project)

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-banner-logo-title "Editor of the century")
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-startup-banner "~/.config/emacs/images/emacs-logo-3.webp")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 3)
                        (agenda . 3)
                        (registers . 3)))
  (setq dashboard-icon-type 'all-the-icons) 
)

(use-package consult)

