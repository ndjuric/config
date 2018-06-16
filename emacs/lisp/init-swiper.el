(use-package swiper
  :bind (
         :map isearch-mode-map
         ("C-c s" . swiper-from-isearch)) ; isearch > swiper
  :config
  (setq swiper-action-recenter t))

(provide 'init-swiper)
