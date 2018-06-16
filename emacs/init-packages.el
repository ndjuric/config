(unless (package-installed-p 'use-package)
	  (package-refresh-contents)
		  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

(setq use-package-enable-imenu-support t)
(use-package system-packages)
(use-package key-chord :config (key-chord-mode 1))
(use-package use-package-chords)
(use-package use-package-ensure-system-package)

(provide 'setup-packages)
