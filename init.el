;; Initialize package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Ensure 'use-package' is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Emacs configuration
(use-package emacs
  :config
  ;; Set Consolas as the default font
  (set-frame-font "Consolas")
  
  ;; Set font size to 12 points
  (set-face-attribute 'default nil :height 130))

;; Install and configure dracula theme
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

;; Install and configure doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Disable async compilation warnings
(setq comp-async-warnings nil)

;; Enable haskell-mode and configure keybindings
(use-package haskell-mode
  :bind (("C-M-x" . haskell-interactive-bring))
  :config
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

;; Enable lsp-mode and configure for haskell-mode
(use-package lsp-mode
  :hook (haskell-mode . lsp-deferred)
  :commands lsp
  :config
  (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
  (setq lsp-haskell-process-args-hie '("-d" "-l" "/tmp/hls.log"))
  (setq lsp-enable-snippet nil) ;; Disable snippet support
  (setq lsp-auto-configure t))

;; Install and configure lsp-haskell
(use-package lsp-haskell
  :ensure t
  :config
  (setq lsp-haskell-server-path "haskell-language-server-wrapper"))

;; Enable lsp-ui for additional UI features
(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))

;; Install and configure treemacs
(use-package treemacs
  :ensure t
  :config
  (treemacs))

;; Bind treemacs show/hide to C-M-s
(global-set-key (kbd "C-M-s") 'treemacs)

;; Set the font size for treemacs
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(treemacs-directory-face ((t (:height 1.00))))
 '(treemacs-file-face ((t (:height 0.90))))
 '(treemacs-root-face ((t (:height 1.00)))))

;; Install and configure company-mode
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :config
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "TAB") #'company-complete-selection))

;; Disable the tool bar
(tool-bar-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-interval 1)
 '(package-selected-packages
   '(company use-package treemacs-all-the-icons lsp-ui lsp-haskell flycheck dracula-theme))
 '(tool-bar-mode nil))
