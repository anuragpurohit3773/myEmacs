;using escape to get out of the command
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;;for split-window-vertically
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-vertically))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(package-selected-packages
   (quote
    (helpful which-key rainbow-delimiters doom-modeline evil counsel ivy-rich ivy use-package))))

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(80 80))
(add-to-list 'default-frame-alist 'alpha '(80 80))
;;line mode
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Package configs everything must come after the package initialization
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq use-package-always-ensure t)
;;setting up ivy

;;ivy for fuzzy finding and many things with counsel
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
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)
                 )
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))
(use-package counsel
  :bind (
         ("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-palenight t))
;;for icons
(use-package all-the-icons)
;;doom mode line

;; Vim mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)

  :custom ( doom-modeline-height 10 ))

;;rainbow delimeter for paranthesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;which key
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.6))


;;helpful for adding more to the descriptions
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

