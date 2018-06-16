(use-package hydra
  :config
  (set-face-attribute 'hydra-face-red nil
                      :foreground "#FF6956" :bold t :background "#383838")
  (set-face-attribute 'hydra-face-blue nil
                      :foreground "Cyan" :bold t :background "#383838")
  (set-face-attribute 'hydra-face-amaranth nil
                      :foreground "#e52b50" :bold t :background "#383838")
  (set-face-attribute 'hydra-face-pink nil
                      :foreground "HotPink1" :bold t :background "#383838")
  (set-face-attribute 'hydra-face-teal nil
                      :foreground "SkyBlue1" :bold t :background "#383838")
  (hydra-add-font-lock))

(defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))

(defhydra hydra-splitter (global-map "C-M-s")
  "splitter"
  ("h" hydra-move-splitter-left)
  ("j" hydra-move-splitter-down)
  ("k" hydra-move-splitter-up)
  ("l" hydra-move-splitter-right))

(provide 'init-hydra)
