(setq confirm-kill-emacs #'y-or-n-p)

(setq user-mail-address "metod303@gmail.com")

(defun is-mac-p ()
	  (eq system-type 'darwin))

(defun is-linux-p ()
	  (eq system-type 'gnu/linux))

(provide 'general)
