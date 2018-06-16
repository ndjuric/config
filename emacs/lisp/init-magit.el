(use-package magit
  :bind (("C-c m b" . magit-blame)
         ("C-c m p" . wh/switch-magit-status-buffer)
         ("C-c m s" . magit-dispatch-popup)
         :map magit-status-mode-map)
  :bind* ("C-c p v". magit-status)
  :config
  ;; Enable the binding for magit-file=popup
  (global-magit-file-mode 1)

  (setq magit-completing-read-function 'ivy-completing-read)

  ;; show word granularity within diff hunks
  (setq-default magit-diff-refine-hunk 'all)

  (progn
    ;; Magit Submodule support
    (dolist (fn '(
                  ;; Below will end up being the last of these newly added fns,
                  ;; and the last element in `magit-status-sections-hook' too.
                  magit-insert-modules-unpulled-from-upstream
                  magit-insert-modules-unpushed-to-pushremote
                  magit-insert-modules-unpushed-to-upstream
                  magit-insert-modules-unpulled-from-pushremote
                  ;; Below will end up being the first of these newly added fns.
                  magit-insert-submodules
                  ))
      (magit-add-section-hook 'magit-status-sections-hook `,fn nil :append)))

  (defun wh/switch-magit-status-buffer ()
    "Allow switching between open magit status buffers."
    (interactive)
    (let* ((buffers
            (--filter
             (eq #'magit-status-mode (with-current-buffer it major-mode))
             (buffer-list))
           )
           (bufs-with-names
            (--map
             (cons (with-current-buffer it (projectile-project-name)) it)
             buffers)
           )
           (chosen-buf
            (cdr
             (assoc
              (completing-read "Git project: " bufs-with-names)
              bufs-with-names
             )
            )
           )
          )
      (switch-to-buffer chosen-buf)
    )
  )
)

;; git-timemachine: to rollback to different commits of files
(use-package git-timemachine
  :bind (("C-c g t" . git-timemachine-toggle)))

;; diff-hl: highlight diffs in the fringe
(use-package diff-hl
  :hook ((dired-mode . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :init
  (global-diff-hl-mode)
  :bind (("C-c h d" . diff-hl-hunk-hydra/body))
  :config
  (defhydra diff-hl-hunk-hydra (:color red)
    ("p" diff-hl-previous-hunk "prev hunk")
    ("n" diff-hl-next-hunk "next hunk")
    ("d" diff-hl-diff-goto-hunk "goto hunk")
    ("r" diff-hl-revert-hunk "revert hunk")
    ("m" diff-hl-mark-hunk "mark hunk")
    ("q" nil "quit" :color blue)))

;; git-messenger: popup commit message at current line
(use-package git-messenger
  :after popup
  :bind(("C-c g m" . git-messenger:popup-message))
  :config
  ;; Enable magit-show-commit instead of pop-to-buffer
  (setq git-messenger:use-magit-popup t)
  (setq git-messenger:show-detail t))

;; git-link: emacs package for getting the github/gitlab/bitbucket URL
(use-package git-link
  :commands (git-link git-link-commit git-link-homepage)
  :bind
  ("C-c g l" . git-link)
  ("C-c g c" . git-link-commit)
  ("C-c g h" . git-link-homepage))

(use-package magit-log :ensure nil
  :init
  (progn
    (setq magit-log-margin '(t age-abbreviated magit-log-margin-width :author 11)))
  :config
 )

;; git-modes: major modes for git config, ignore and attributes files
(use-package gitignore-mode)
(use-package gitconfig-mode)
(use-package gitattributes-mode)

;; gist: Yet another Emacs paste mode, this one for Gist.
(use-package gist :defer t)

(provide 'init-magit)
