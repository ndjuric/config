(use-package projectile
  :defer 1
  :config
  (setq projectile-completion-system 'ivy
        projectile-enable-caching t)

  ;; ignore stack directory as projectile project
  (add-to-list 'projectile-ignored-projects
               (concat user-home-directory ".stack/global-project/"))

  (setq projectile-ignored-project-function #'my-projectile-ignore-project)
  (bind-keys ("C-c p r" . projectile-replace-regexp))
  (projectile-mode))

(provide 'init-projectile)
