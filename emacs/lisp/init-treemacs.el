(use-package treemacs :defer t
  :config
  (progn
    (setq treemacs-follow-after-init t
          treemacs-width 60
          treemacs-indentation 1
          treemacs-git-integration t
          treemacs-collapse-dirs 3
          treemacs-silent-refresh t
          treemacs-silent-filewatch t
          treemacs-change-root-without-asking t
          treemacs-recenter-after-file-follow t
          treemacs-sorting 'alphabetic-desc
          treemacs-show-hidden-files t
          treemacs-never-persist nil
          treemacs-is-never-other-window t
          treemacs-position 'right
          treemacs-no-png-images t
          treemacs-indentation-string (propertize " ⫶ " 'face 'font-lock-comment-face))

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple))))

  :bind
  (:map global-map
		([f8] . treemacs)
        ("C-c s t" . treemacs-find-file)))

(use-package treemacs-projectile
  :defer t
  :after treemacs
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header))

(provide 'init-treemacs)
