(when (is-mac-p) (setq ns-function-modifier 'hyper)) ;; make Fn do hyper

;; exec-path-from-shell: ensure environment variables inside Emacs look the same
;; as in the users shell
(use-package exec-path-from-shell
  :if (is-mac-p)
  :init
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

;; delete files by moving to trash in macOS
(use-package osx-trash
  :if (is-mac-p)
  :config
  (setq delete-by-moving-to-trash t)
  (osx-trash-setup))

(provide 'init-osx)
