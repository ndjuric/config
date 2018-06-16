(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)

(semantic-mode 1)

(defun my/cedet-hook ()
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))

(add-hook 'c-mode-common-hook 'my/cedet-hook)
(add-hook 'c-mode-hook 'my/cedet-hook)
(add-hook 'c++-mode-hook 'my/cedet-hook)

;; setup GDB
(setq gdb-many-windows t gdb-show-main t)

(require 'ede)
(global-ede-mode)

(provide 'init-cedet)
