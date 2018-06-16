(use-package company
  :config
  (bind-keys
   :map company-active-map
   ("M-p" . nil)
   ("M-n" . nil)
   ("C-m" . nil)
   ("C-h" . nil)
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("<tab>" . company-complete-common)
   ("C-t" . company-show-doc-buffer))

  ;; replace `dabbrev-expand' with `hippie-expand' which does a lot more
  (bind-key "M-/" 'hippie-expand)

  ;; don't downcase results from company-dabbrev
  (setq company-dabbrev-downcase nil)
  
  ;; use only buffers with same major-mode for company-dabbrev
  (setq company-dabbrev-other-buffers t)
  (bind-key "C-<tab>" 'company-dabbrev)

  (defun ora-company-number ()
    "Forward to `company-complete-number'.
     Unless the number is potentially part of the candidate.
     In that case, insert the number."
    (interactive)
    (let* ((k (this-command-keys))
           (re (concat "^" company-prefix k)))
      (if (cl-find-if (lambda (s) (string-match re s))
                      company-candidates)
          (self-insert-command 1)
        (company-complete-number
         (if (equal k "0")
             10
           (string-to-number k))))))

  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x) 'ora-company-number))
          (number-sequence 0 9))
    (define-key map " " (lambda ()
                          (interactive)
                          (company-abort)
                          (self-insert-command 1))))

  ;; set defaults for company-mode
  (setq company-tooltip-flip-when-above t
        company-minimum-prefix-length 3
        company-idle-delay 0.2
        company-selection-wrap-around t
        company-show-numbers t
        company-require-match 'never
        company-tooltip-align-annotations t)

  ;; Suspend page-break-lines-mode while company menu is active
  (defvar sanityinc/page-break-lines-on-p nil)
  (make-variable-buffer-local 'sanityinc/page-break-lines-on-p)

  (defun sanityinc/page-break-lines-disable (&rest ignore)
    (when (setq sanityinc/page-break-lines-on-p (bound-and-true-p page-break-lines-mode))
      (page-break-lines-mode -1)))

  (defun sanityinc/page-break-lines-maybe-reenable (&rest ignore)
    (when sanityinc/page-break-lines-on-p
      (page-break-lines-mode 1)))

  (add-hook 'company-completion-started-hook 'sanityinc/page-break-lines-disable)
  (add-hook 'company-completion-finished-hook 'sanityinc/page-break-lines-maybe-reenable)
  (add-hook 'company-completion-cancelled-hook 'sanityinc/page-break-lines-maybe-reenable))

(use-package company-statistics
  :defer 1
  :after company
  :config (company-statistics-mode))

(provide 'init-company)
