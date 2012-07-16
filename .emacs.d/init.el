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

(tool-bar-mode 0)

(savehist-mode 1)
(setq echo-keystrokes 0.1)

(setq recentf-max-saved-items 500)
;; (require 'recentf-ext)

;; (require 'auto-complete)
;; (global-auto-complete-mode t)

(define-key global-map (kbd "C-o") 'dabbrev-expand)

(require 'anything-startup)
(define-key global-map (kbd "C-:") 'anything-for-files)

;;; Programming Language perl
(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\|t\\|cgi\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(defalias 'perl-mode 'cperl-mode)
 
(setq cperl-indent-level 4
      cperl-continued-statement-offset 4
      cperl-close-paren-offset -4
      cperl-label-offset -4
      cperl-comment-column 40
      cperl-highlight-variables-indiscriminately t
      cperl-indent-parens-as-block t
      cperl-tab-always-indent nil
      cperl-font-lock t)
(add-hook 'cperl-mode-hook
          '(lambda ()
             (progn
               (setq indent-tabs-mode nil)
               (setq tab-width nil)
 
               ; perl-completion
               (require 'auto-complete)
               (require 'perl-completion)
               (add-to-list 'ac-sources 'ac-source-perl-completion)
               (perl-completion-mode t)
	       )))

(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))
(global-set-key "\C-ct" 'perltidy-region)
(global-set-key "\C-c\C-t" 'perltidy-defun)
