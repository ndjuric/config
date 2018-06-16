(use-package php-mode :ensure t
  :defer t
  :mode "\\.php$"
)

(use-package php-auto-yasnippets :ensure t
  :after php-mode)

(provide 'init-php)
