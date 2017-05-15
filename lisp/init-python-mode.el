(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)

(defun setup-python-interpreter (&rest args)
  ;; Adapted from Prelude, fix problem with ipython
  (if (executable-find "ipython")
      (if (version< (replace-regexp-in-string "\n$" "" (shell-command-to-string "ipython --version")) "5")
          ;; This is due to some changes in the iPython interpreter
          (progn
            (setq python-shell-interpreter-args "-i")
            (setq
             python-shell-interpreter "ipython"
             python-shell-prompt-regexp "In \\[[0-9]+\\]: "
             python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
             python-shell-completion-setup-code
             "from IPython.core.completerlib import module_completion"
             python-shell-completion-module-string-code
             "';'.join(module_completion('''%s'''))\n"
             python-shell-completion-string-code
             "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"))
        (setq python-shell-interpreter-args "-i --simple-prompt"))))

(use-package anaconda-mode
  :defer t
  :init
  (progn (add-hook 'python-mode-hook 'anaconda-mode))
  (setq python-shell-interpreter "ipython")
  :config
  (setup-python-interpreter t)
  (add-hook 'anaconda-mode-hook 'anaconda-eldoc-mode)
  (bind-keys
   :map anaconda-mode-map
   ("s-]"     . anaconda-mode-find-definitions)
   ("s-["     . anaconda-mode-go-back)
   ("C-c g g" . anaconda-mode-find-definitions)
   ("C-c g a" . anaconda-mode-find-assignments)
   ("C-c g d" . anaconda-mode-show-doc)
   ("C-c g b" . anaconda-mode-go-back)))

(use-package company-anaconda
  :after anaconda-mode
  :config
  (add-hook 'anaconda-mode-hook
            (lambda ()
              (add-to-list (make-local-variable 'company-backends)
                           'company-anaconda))))

(use-package ein
  :commands (ein:jupyter-server-start)
  :ensure t)

(use-package pyvenv
  :after anaconda-mode
  :init (setenv "WORKON_HOME" "~/anaconda/envs")
  :config
  (progn
    (dolist (func '(pyvenv-workon pyvenv-activate pyvenv-deactivate))
      (advice-add func :after #'setup-python-interpreter))))

(use-package py-yapf
  :if (executable-find "yapf")
  :commands (py-yapf-buffer)
  :bind (:map python-mode-map
              ("C-c =" . py-yapf-buffer)))


(provide 'init-python-mode)
