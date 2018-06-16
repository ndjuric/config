(use-package smex
  :config (smex-initialize))

;; ivy: incremental narrowing framework for Emacs
(use-package ivy
  :bind (("C-c u" . ivy-resume))
  :init (ivy-mode 1)
  :config

  (bind-chords
   :map ivy-minibuffer-map
   ("m," . ivy-beginning-of-buffer)
   (",." . ivy-end-of-buffer))

  (setq ivy-use-virtual-buffers t
        ivy-height 13
        ivy-count-format "%d/%d "
        ivy-initial-inputs-alist nil
        ivy-virtual-abbreviate 'full ; Show the full virtual file paths
        ivy-extra-directories nil ; default value: ("../" "./")
        ivy-format-function 'ivy-format-function-arrow
        ivy-wrap t
        ivy-use-selectable-prompt t)

  (bind-keys
   :map ivy-occur-grep-mode-map
   ("n" . ivy-occur-next-line)
   ("p" . ivy-occur-previous-line)
   ("b" . backward-char)
   ("f" . forward-char)
   ("v" . ivy-occur-press) ; default f
   ("RET" . ivy-occur-press)))

(provide 'init-ivy)
