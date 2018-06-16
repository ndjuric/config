(use-package counsel
  :after ivy
  :bind* (([remap execute-extended-command] . counsel-M-x))
  :chords (("JJ" . counsel-imenu)
           (";'" . counsel-M-x))
  :init
  (counsel-mode)

  (bind-keys
   :map read-expression-map
   ("C-r" . counsel-expression-history))

  (with-eval-after-load 'org-agenda
    (bind-key "C-c C-q" #'counsel-org-tag-agenda org-agenda-mode-map))

  :config

  (if (executable-find "rg")
      ;; if rg is installed, use rg for `counsel-grep-or-swiper' and `counsel-rg'
      (setq counsel-grep-base-command "rg -i -M 120 --no-heading --line-number --color never '%s' %s"
            ;; add `--follow' option to allow search through symbolic links
            counsel-rg-base-command "rg --line-number --color never -i --follow --mmap --no-heading %s")
    ;; ignore case sensitivity for counsel grep
    (setq counsel-grep-base-command "grep -nEi \"%s\" %s"))

  (defun reloading (cmd)
    (lambda (x)
      (funcall cmd x)
      (ivy--reset-state ivy-last)))
  (defun given-file (cmd prompt) ; needs lexical-binding
    (lambda (source)
      (let ((target
             (let ((enable-recursive-minibuffers t))
               (read-file-name
                (format "%s %s to:" prompt source)))))
        (funcall cmd source target 1))))
  (defun confirm-delete-file (x)
    (dired-delete-file x 'confirm-each-subdirectory))

  (ivy-add-actions
   'counsel-find-file
   `(("m" ,(reloading (given-file #'rename-file "Move")) "move")
     ("d" ,(reloading #'confirm-delete-file) "delete")))

  (ivy-add-actions
   'counsel-projectile-find-file
   `(("d" ,(reloading #'confirm-delete-file) "delete")
     ("m" ,(reloading (given-file #'rename-file "Move")) "move")
     ("b" counsel-find-file-cd-bookmark-action "cd bookmark")))

  ;; find file at point
  (setq counsel-find-file-at-point t)

  ;; ignore . files or temporary files
  (setq counsel-find-file-ignore-regexp
        (concat
         ;; File names beginning with # or .
         "\\(?:\\`[#.]\\)"
         ;; File names ending with # or ~
         "\\|\\(?:\\`.+?[#~]\\'\\)"))

  (bind-keys
   ([remap describe-bindings] . counsel-descbinds)
   ([remap finder-by-keyword] . counsel-package) ;C-h p
   ([remap bookmark-jump] . counsel-bookmark) ;Jump to book or set it if it doesn't exist, C-x r b
   ([remap bookmark-set] . counsel-bookmark)  ;C-x r m
   ([remap find-file] . counsel-find-file)
   ("C-c g g" . counsel-git-grep)
   ("C-c d s" . describe-symbol)
   ("C-c d f" . counsel-faces)
   ("C-c d d" . counsel-descbinds)
   ("C-c r g" . counsel-rg)))

;; Add more ivy features for projectile related commands
(use-package counsel-projectile
  :after (counsel projectile)
  :config (counsel-projectile-mode 1))

(provide 'init-counsel)
