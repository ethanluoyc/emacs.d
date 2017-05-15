(global-auto-revert-mode t)

(use-package neotree :ensure t
  :init
  (setq neo-window-fixed-size nil)
  (setq neo-show-hidden-files t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  :config
  (global-set-key [f8] 'neotree-toggle))

(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(provide 'yl-misc)
