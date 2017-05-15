(use-package recentf
  :bind (("C-x C-r" . recentf-open-files))
  :init
  (setq-default
   recentf-max-saved-items 1000
   recentf-exclude '("/tmp/" "/ssh:"))
  :config
  (recentf-mode 1))

(provide 'init-recentf)
