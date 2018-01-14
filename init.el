
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(blink-cursor-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(column-number-mode t)
(show-paren-mode t)
(global-font-lock-mode t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(defconst is-a-mac? (eq system-type 'darwin))
(when is-a-mac? (setq mac-command-modifier 'meta))
(setq-default indent-tabs-mode nil)

(use-package helm
  :ensure t
  :demand t
  :bind
  (("M-y"     . 'helm-show-kill-ring)
   ("M-x"     . 'helm-M-x)
   ("C-x C-b" . 'helm-mini)
   ("C-x b"   . 'helm-mini)
   ("C-x C-f" . 'helm-find-files)
   ("C-s"     . 'helm-regexp)
   (:map helm-map
         ("C-n"    . 'helm-next-line)
         ("C-p"    . 'helm-previous-line)
         ("C-h"    . 'helm-next-source)
         ("C-l"    . "RET")
         ([escape] . 'helm-keyboard-quit)))
  :config
  (use-package helm-swoop
    :ensure t
    :demand t)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t)
  (setq helm-move-to-line-cycle-in-source t))


(use-package org
  :ensure t
  :demand t
  :bind
  (("C-c a" . 'org-agenda)
   ("C-c l" . 'org-store-link))
  :config
  (setq org-todo-keyword-faces
     '(("TODO"    . org-warning)
       ("WAITING" . (:foreground "purple4" :weight bold))
       ("IDEA"    . (:foreground "DodgerBlue1" :weight bold))))
  (setq org-todo-keywords
        '((sequence "TODO(t)"
                    "IN-PROGRESS(p)"
                    "WAITING(w)"
                    "IDEA(i)"
                    "DONE(d)")))
  (setq org-log-done t)
  (setq org-indent-mode t)
  (setq org-use-fast-todo-selection t)
  (setq org-agenda-files '("c:/Users/517083/Desktop/journal.org"))
  (setq org-agenda-files (file-expand-wildcards "~/Dropbox/org/*.org")))

(use-package evil
  :ensure t
  :demand t
  :config
  (evil-mode 1)
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode))
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))
  :init
  (defun switch-to-last-buffer ()
    (interactive)
    (switch-to-buffer nil))
  :bind
  (("C-w" . evil-delete-backward-word))
  (:map evil-ex-map
        ("e" . helm-find-files)
        ("ls". helm-buffers-list)
        ("b" . switch-to-last-buffer))
  (:map evil-normal-state-map
        ("/" . helm-swoop)))

(use-package nlinum-relative
  :ensure t
  :demand t
  :config
  (nlinum-relative-on)
  (nlinum-relative-setup-evil)
  (setq nlinum-relative-redisplay-delay 0))

(use-package magit
  :ensure t
  :demand t
  :bind
  (("C-x g" . magit)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)


