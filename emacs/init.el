;; Startup 
(defvar gc-cons-threshold--orig gc-cons-threshold)
(setq gc-cons-threshold (* 100 1024 1024) gc-cons-percentage 0.6)

(defun set-custom-gc-threshold ()
  "Reset `gc-cons-threshold' and `gc-cons-percentage' to their default values."
  (setq gc-cons-threshold gc-cons-threshold--orig gc-cons-percentage 0.1))

;; Packages
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(require 'use-package)

;; init directory / package customization 
(add-to-list 'load-path (concat user-emacs-directory "lisp/"))

;; set home and emacs directories
(defvar user-home-directory (concat (getenv "HOME") "/"))
(setq user-emacs-directory (concat user-home-directory ".emacs.d/"))

;; save custom file to a separate directory
(setq custom-file (concat user-emacs-directory "custom/settings.el"))
(load custom-file :noerror :nomessage) ; load custom-file silently

;; load general
(load (locate-user-emacs-file "general.el") nil :nomessage)

;; load packages config
(load (locate-user-emacs-file "init-packages.el") nil :nomessage)

(require 'init-osx)
(require 'init-treemacs)
(require 'init-ibuffer)
(require 'init-hydra)
(require 'init-company)
(require 'init-ace-window)
(require 'init-projectile)
(require 'init-yas)
(require 'init-magit)
(require 'init-buffers)
(require 'init-ivy)
(require 'init-counsel)
(require 'init-swiper)
(require 'init-highlight)
(require 'init-mode-line)
(require 'init-editing)
(require 'init-misc)
(require 'init-visual)
(require 'init-zenburn)
(require 'init-minibuffer)
(require 'init-cedet)
(require 'init-c)
(require 'init-php)

(package-install-selected-packages)

(require 'server)
(unless (server-running-p) (server-start))

;; set gc-cons-threshold back to original value
(add-hook 'emacs-startup-hook #'set-custom-gc-threshold)
