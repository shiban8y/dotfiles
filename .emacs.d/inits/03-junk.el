;; open-junk-file
(require 'open-junk-file)
(setq open-junk-file-format "~/Documents/junk/%Y-%m-%d-%H%M%S.")
(global-set-key "\C-xj" 'open-junk-file)

;; org
(require 'org)
;; (require 'ob-C)
;; (require 'ob-ruby)

(setq org-directory "~/Documents/junk")
(setq org-agenda-files (list org-directory))

(setq org-src-fontify-natively t)

(defun my-org-confirm-babel-evaluate (lang body)
  (not (or (string= lang "ditaa")
           (string= lang "emacs-lisp")
           (string= lang "ruby")
           (string= lang "C")
           (string= lang "cpp")
           )))

(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
