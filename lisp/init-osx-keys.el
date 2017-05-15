(when *is-a-mac*
  ;; (setq mac-command-modifier 'meta)
  ;; (setq mac-option-modifier 'none)
  (setq-default default-input-method "MacOSX")
  ;; Make mouse wheel / trackpad scrolling less jerky
  (setq mouse-wheel-scroll-amount '(1
                                    ((shift) . 5)
                                    ((control))))
  (dolist (multiple '("" "double-" "triple-"))
    (dolist (direction '("right" "left"))
      (global-set-key (read-kbd-macro (concat "<" multiple "wheel-" direction ">")) 'ignore)))
  (global-set-key (kbd "M-`") 'ns-next-frame)
  (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
  (global-set-key (kbd "M-˙") 'ns-do-hide-others)
  (after-load 'nxml-mode
    (define-key nxml-mode-map (kbd "M-h") nil))
  (global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports for cmd-option-h
  )

(use-package smooth-scroll
  :disabled t
  :ensure t
  :config
  (smooth-scroll-mode 1)
  (setq smooth-scroll/vscroll-step-size 5))

(use-package reveal-in-osx-finder
  :if (eq system-type 'darwin)
  :ensure t
  :bind ("C-c f o" . reveal-in-osx-finder))

(use-package osx-trash                  ;; Trash support for OS X
  :if (eq system-type 'darwin)
  :ensure t
  :init (osx-trash-setup))

(when (eq system-type 'darwin)
  (use-package ns-win                     ;; OS X window support
    :if (eq system-type 'darwin)
    :defer t
    :init
    (setq ns-pop-up-frames nil)
    :config))

(setq mouse-wheel-scroll-amount '(1
                                  ((shift) . 5)
                                  ((control))))

(use-package osx-pseudo-daemon
  :if (eq system-type 'darwin)
  :load-path "site-lisp/osx-pseudo-daemon")

(provide 'init-osx-keys)
