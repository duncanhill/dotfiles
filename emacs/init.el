;; Package Configuration
(package-initialize)
(setq use-package-always-ensure t)

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; General
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      inhibit-startup-screen t)

(add-to-list 'exec-path "/usr/local/bin")

;; Easy navigation to this file.
(defun my/init-file ()
  (interactive)
  (find-file user-init-file))
(defun my/init-file-reload ()
  (interactive)
  (load-file user-init-file))

(tool-bar-mode -1)
(display-time-mode 1)

(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))

(use-package diminish
  :ensure t)

;; Interactive Completion and Search
(use-package ivy
  :ensure t
  :diminish
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :diminish
  :config
  (counsel-mode 1))

(use-package swiper
  :ensure t
  :diminish
  :config
  (global-set-key (kbd "C-s") 'swiper-isearch)
  (global-set-key (kbd "C-r") 'swiper-isearch-backward))

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; Line Numbers
(global-display-line-numbers-mode)

;; Commenting
(use-package evil-nerd-commenter
  :ensure t
  :config
  (evilnc-default-hotkeys t))

;; Parens
(use-package smartparens
  :ensure t
  :diminish
  :config
  (smartparens-global-mode t))

(use-package rainbow-delimiters
  :ensure t
  :diminish
  :config
  (rainbow-delimiters-mode 1)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode-enable))


;; Themes
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-one t)

  (doom-themes-visual-bell-config))

;; Trailing Whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Multiple Cursors
(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; Web Mode
(use-package web-mode
  :ensure t
  :init
;  (setq web-mode-enable-auto-closing t)
;  (setq web-mode-tag-auto-close-style )
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ftl\\'" . web-mode)))

;; Jinja2 Mode
(use-package jinja2-mode
  :ensure t)

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Magit
(use-package magit
  :ensure t)

;; Buffer Sizing
(use-package golden-ratio
  :ensure t
  :diminish
  :config
  (golden-ratio-mode 1))

;; HCL
(use-package hcl-mode
  :ensure t)

;; Terraform
(use-package terraform-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

;; YAML
(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode)))

;; Autocompletion
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  :hook ((csharp-mode . lsp)))

;; C#
(use-package csharp-mode
  :ensure t
  :config
  (add-hook 'csharp-mode-hook 'rainbow-delimiters-mode-enable))
(use-package lsp-mode
  :ensure t
  :hook ((csharp-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  :config
  (push "[/\\\\]*\\node_modules\\'" lsp-file-watch-ignored))

;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "74ba9ed7161a26bfe04580279b8cad163c00b802f54c574bfa5d924b99daa4b9" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "01cf34eca93938925143f402c2e6141f03abb341f27d1c2dba3d50af9357ce70" "bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" default))
 '(global-auto-revert-mode t)
 '(package-selected-packages
   '(company-lsp lsp-mode csharp-mode which-key magit markdown-mode jinja2-mode multiple-cursors evil-nerd-commenter yaml-mode company hcl-mode golden-ratio projectile web-mode use-package smartparens rainbow-delimiters helm doom-themes diminish counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
