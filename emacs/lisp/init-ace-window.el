(use-package ace-window
  :commands (ace-window)
  :bind* ("C-c w" . ace-window)
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-dispatch-always t "enable aw dispatch even for just one window")

  (aw-dispatch-alist
   '((?x aw-delete-window " Ace - Delete Window")
     (?m aw-swap-window " Ace - Swap Window")
     (?n aw-flip-window)
     (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
     (?j aw-switch-buffer-in-window "Select Buffer")
     (?o delete-other-windows " Ace - Maximize Window")
     (?c hydra-window-scroll/body)
     (?t aw-split-window-fair "Ace- split fairly")
     (?y hydra-window-size/body)
     (?? aw-show-dispatch-help)))

  :config
  (defhydra hydra-window-size (:color red)
    "Windows size"
    ("b" shrink-window-horizontally "shrink horizontal")
    ("p" shrink-window "shrink vertical")
    ("n" enlarge-window "enlarge vertical")
    ("f" enlarge-window-horizontally "enlarge horizontal")
    ("m" toggle-frame-fullscreen "maximize frame")
    ("r" balance-windows "balance windows")
    ("q" nil :color blue))

  (defhydra hydra-window-scroll (:color red)
    "Scroll other window"
    ("<SPC>" scroll-other-window "scroll")
    ("b" scroll-other-window-down "scroll down")
    ("q" nil :color blue)))

(provide 'init-ace-window)
