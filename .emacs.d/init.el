(require 'package)
(add-to-list 'package-archives
 	     '("marmalade" . "http://maramalade-repo.org/packages/"))
(add-to-list 'package-archives
 	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
 	     '("ELPA" . "http://tromey.com/elpa/"))
(package-initialize)

;; (add-to-list 'load-path "~/.emacs.d/auto-install")

(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)

(add-to-list 'default-frame-alist '(font . "MyricaM M-13.5"))
;;(add-to-list 'default-frame-alist '(font . "Ricty Diminished Discord-13.5"))

;; (setq ediff-window-setup-function 'ediff-setup-windows-plain)

(show-paren-mode t)

(global-linum-mode 1)
(line-number-mode 1)
(setq linum-format "%4d")
(column-number-mode 1)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(savehist-mode 1)
(setq echo-keystrokes 0.1)

;; (setq recentf-max-saved-items 500)
;; (require 'recentf-ext)

(when (require 'recentf nil t)
  (setq recentf-save-file "~/.emacs.d/.recentf")
  (setq recentf-max-saved-items 1000)
  (setq recentf-exclude '(".recentf"))
  ;; (setq recentf-auto-cleanup 10)
  ;; (setq recentf-auto-save-timer
  ;;       (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1)) 

;; (require 'auto-complete)
;; (global-auto-complete-mode t)


(setq make-backup-files nil)

(setq tramp-default-method "plink")

; server start for emacs-client
;; (require 'server)
;; (unless (server-running-p)
;;   (server-start))

;; helm
(require 'helm-config)
(helm-descbinds-mode)
(let ((key-and-func
       `(
         (,(kbd "C-:")     helm-mini)
         (,(kbd "C-x C-f") helm-find-files)
         (,(kbd "M-s")     helm-occur)
         (,(kbd "M-x")     helm-M-x)
         (,(kbd "M-y")     helm-show-kill-ring)
         (,(kbd "M-z")     helm-do-grep)
         (,(kbd "C-S-h")   helm-descbinds)
        )
       ))
  (cl-loop for (key func) in key-and-func
   	do (global-set-key key func))
  )

(custom-set-variables
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-recentf
                               helm-source-files-in-current-dir
                               )))

;; anything
;; (require 'anything-startup)
;; (define-key global-map (kbd "C-:") 'anything-for-files)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; starter-kit
;;(require 'starter-kit)
;(require 'starter-kit-perl)

;; (require 'auto-install)
;; (auto-install-update-emacswiki-package-name t)
;; (auto-install-compatibility-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color-theme
(require 'color-theme)
;; (require 'color-theme-tango)
;; (require 'color-theme-heroku)
(color-theme-initialize)
;; (color-theme-tango)
(color-theme-dark-laptop)

;; (require 'hl-line+)
;; (global-linum-mode t)
;; (global-hl-line-mode t)
;; (toggle-hl-line-when-idle 1)


(define-key global-map "\C-h" 'delete-backward-char)
(define-key global-map (kbd "C-o") 'dabbrev-expand)

;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.\\(md\\|mkdn\\)\\'" . markdown-mode))
(defun markdown-custom ()
  "markdown-mode-hook"
  (auto-fill-mode -1)
  (setq markdown-command "c:\tools\Ruby22-x64\bin\kramdown"))  ;; コマンドパスの設定
(add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))

;; ddskk
(when (require 'skk nil t)
  (global-set-key (kbd "C-\\") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))

;; (global-set-key (kbd "C-x C-j") 'skk-mode)
;; (with-eval-after-load 'dired-x
;;   (global-set-key (kbd "C-x C-j") 'skk-mode))

;(require 'drill-instructor)
;(setq drill-instructor-global t)
;; Setup C-h

;;次のウィンドウへ移動
(define-key global-map (kbd "C-x C-n") 'next-multiframe-window)
;;前のウィンドウへ移動
(define-key global-map (kbd "C-x C-p") 'previous-multiframe-window)

;; スクリーンの最大化
 (set-frame-parameter nil 'fullscreen 'maximized)

;; 自動改行をoffにする
(setq text-mode-hook 'turn-off-auto-fill)

;;org-modeで行末で折り返しをする
(setq org-startup-truncated nil)
(defun change-truncation()
  (interactive)
  (cond ((eq truncate-lines nil)
         (setq truncate-lines t))
        (t
         (setq truncate-lines nil))))

(setq org-capture-templates
   '(("t" "Task" entry (file (expand-file-name (concat org-directory "/task.org")))
      "* TODO %?\n    %i\n   %a\n    %T")
     ("n" "note" entry (file (expand-file-name (concat org-directory "/notes.org")))
      "* %?\n   %a\n    %T")
     ("r" "reading" entry (file (expand-file-name (concat org-directory "/reading.org")))
      "* %?\n   %a\n    %T")))

(global-set-key (kbd "C-c c") 'org-capture)


(setq exec-path (cons "C:/Emacs/libexec/emacs/24.5/x86_64-pc-mingw32" exec-path))

(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a"))
(setq migemo-dictionary "C:/Users/SV48723/AppData/Roaming/.emacs.d/etc/dict/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
;; (setq migemo-use-pattern-alist t)
;; (setq migemo-use-frequent-pattern-alist t)
;; (setq migemo-pattern-alist-length 1000)  
(load-library "migemo")
(migemo-init)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-capture-templates
   (quote
    (("t" "Task" entry
      (file
       (expand-file-name
        (concat org-directory "/task.org")))
      "* TODO %?
    %i
   %a
    %T")
     ("n" "note" entry
      (file
       (expand-file-name
        (concat org-directory "/notes.org")))
      "* %?
   %a
    %T")
     ("r" "reading" entry
      (file
       (expand-file-name
        (concat org-directory "/reading.org")))
      "* %?
   %a
    %T")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; eでwgrepモードにする
(setf wgrep-enable-key "e")
;;; wgrep終了時にバッファを保存
(setq wgrep-auto-save-buffer t)
;;; read-only bufferにも変更を適用する
(setq wgrep-change-readonly-file t)
