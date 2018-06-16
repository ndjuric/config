(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

;; better defaults
;; don't show splash screen when starting emacs
(setq inhibit-splash-screen t)
;; don't echo startup message of GNU emacs
(setq inhibit-startup-echo-area-message t)

;; set scratch major mode to `emacs-lisp-mode'
(setq initial-major-mode 'emacs-lisp-mode)

;;; all frame related settings
;; cursor settings
(setq-default cursor-type '(bar . 1))
;; start in fullscreen
(toggle-frame-fullscreen)
;; disable annoying cursor blinks
(blink-cursor-mode -1)
;; disable the toolbar
(tool-bar-mode -1)
;; disable the menu bar
(menu-bar-mode -1)
;; silence all bell rings
(setq ring-bell-function 'ignore)
;; Do not make mouse wheel accelerate its action (example: scrolling)
(setq mouse-wheel-progressive-speed nil)

(setq frame-resize-pixelwise t) ; Allow frame size to inc/dec by a pixel
(setq tooltip-mode nil) ; Disable tooltip appearance on mouse hover

;; display date and time
(setq display-time-format "%a-%d %H:%M")
(setq display-time-default-load-average nil)
(display-time-mode)

;; set continuation indicators to right fringe only
(setf (cdr (assq 'continuation fringe-indicator-alist))
      ;; '(nil nil) ;; no continuation indicators
      '(nil right-arrow) ;; right indicator only
      ;; '(left-curly-arrow nil) ;; left indicator only
      ;; '(left-curly-arrow right-curly-arrow) ;; default
      )

;; make sure emacsclient starts at fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; make the titlebar transparent in mac
(when (is-mac-p)
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

;; remove ugly scrollbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; resize windows proportionally
(setq window-combination-resize t)

;; Show actual lines instead of the page break char ^L
;; enter page-break character in Emacs by entering `C-q C-l'
(use-package page-break-lines
  :hook ((prog-mode . page-break-lines-mode)
         (org-mode . page-break-lines-mode)))

;; column-enforce-mode: highlight characters which exceed fill-column
(use-package column-enforce-mode
  :config
  (add-hook 'prog-mode-hook (lambda ()
                              (unless (eq major-mode 'web-mode)
                                (column-enforce-mode))))
  
  ;; enforce a column of 80 for highlighting
  (setq column-enforce-column 80)
  (set-face-attribute 'column-enforce-face nil
                      :underline nil :foreground "firebrick3")
  (setq column-enforce-comments nil))

;; indicate buffer boundaries in the fringe
(setq-default indicate-buffer-boundaries '((top . right) (bottom . right)))

;; dimer: Interactively highlight which buffer is active by dimming the others.
(use-package dimmer
  :hook ((after-init . dimmer-mode))
  :config
  (setq-default dimmer-fraction 0.1))

;; fontify-face: Fontify symbols representing faces with that face.
(use-package fontify-face :defer t)

(provide 'init-visual)
