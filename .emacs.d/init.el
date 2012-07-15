(set-face-attribute 'default nil
		    :family "Ricty"
		    :height 160)
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))

(add-to-list 'load-path "~/.emacs.d/auto-install/")
(require 'auto-install)

(auto-install-update-emacswiki-package-name t)

(auto-install-compatibility-setup)

(add-to-list 'default-frame-alist '(font . "ricty-13.5"))

(add-to-list 'load-path "~/.emacs.d/color-theme/")
(require 'color-theme)
(require 'color-theme-tango)
(color-theme-initialize)
(color-theme-tango)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(define-key global-map "\C-h" 'delete-backward-char)

(require 'hl-line+)
(global-hl-line-mode 0)
(toggle-hl-line-when-idle 1)

(show-paren-mode t)

(line-number-mode 1)
(column-number-mode 1)

(savehist-mode 1)
(setq echo-keystrokes 0.1)

(setq recentf-max-saved-items 500)
;; (require 'recentf-ext)

;; (require 'auto-complete)
;; (global-auto-complete-mode t)

(require 'anything-startup)
(define-key global-map (kbd "C-:") 'anything-for-files)



