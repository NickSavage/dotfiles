(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(add-hook 'before-save-hook #'gofmt-before-save)
(setq catppuccin-flavor 'latte)
(setq backup-directory-alist '(("." . "~/.saves")))
(electric-pair-mode t)


(use-package evil
  :ensure t
  :init
  (setq evil-want-C-i-jump nil)
  (evil-mode t))

(use-package magit
  :ensure t
  :defer)

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package vterm
  :ensure t
  :config
  (add-to-list 'evil-emacs-state-modes 'vterm-mode))

(use-package company
  :config
  (global-company-mode))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package prettier
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-prettier-mode))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))

(use-package swift-mode
  :hook (swift-mode . (lambda () (lsp)))
  :config (add-hook 'after-save-hook 'swift-format-current-file))

(defun swift-format-current-file ()
  "Format the file associated with the current buffer with Swift-Format"
  (interactive)
  (let ((file-name (buffer-file-name)))
    (when file-name
      (save-excursion
        (shell-command (format "swift-format --in-place %s" file-name) nil t))
      (revert-buffer nil t))))

(defun xcode-build()
  (interactive)
  (shell-command-to-string
    "osascript -e 'tell application \"Xcode\"' -e 'set targetProject to active workspace document' -e 'build targetProject' -e 'end tell'"))
(defun xcode-run()
  (interactive)
  (shell-command-to-string
    "osascript -e 'tell application \"Xcode\"' -e 'set targetProject to active workspace document' -e 'stop targetProject' -e 'run targetProject' -e 'end tell'"))
(defun xcode-build-run()
  (interactive)
  (xcode-build)
  (xcode-run))
(defun xcode-test()
  (interactive)
  (shell-command-to-string
    "osascript -e 'tell application \"Xcode\"' -e 'set targetProject to active workspace document' -e 'stop targetProject' -e 'test targetProject' -e 'end tell'"))
(defun nsavage-load-new-vterm ()
  (interactive)
  (let ((current-prefix-arg t))
    (call-interactively #'vterm)))
(global-set-key (kbd "C-c t") 'nsavage-load-new-vterm)
(global-set-key (kbd "C-s") 'swiper-isearch)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(catppuccin))
 '(custom-safe-themes
   '("1930427eae3d4d830a43fd79fbda76021138b929c243a4e8606cf4f0531ea17c" "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "674aef6026ad23fb118cbfc773c0ef939ed340543abae08957db71d4b96ad202" default))
 '(exec-path
   '("/opt/homebrew/bin" "/opt/homebrew/sbin" "/usr/local/bin" "/System/Cryptexes/App/usr/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin" "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin" "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin" "/Library/Apple/usr/bin" "/usr/local/go/bin" "/Applications/Emacs.app/Contents/MacOS/bin-arm64-11" "/Applications/Emacs.app/Contents/MacOS/libexec-arm64-11" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Users/nick/.nvm/versions/node/v20.16.0/bin"))
 '(ns-alternate-modifier 'super)
 '(ns-command-modifier 'meta)
 '(package-selected-packages
   '(lsp-sourcekit swift-mode swift-ts-mode treesit-auto lsp-mode exec-path-from-shell prettier prettier-js-args prettier-js swiper dired-sidebar projectile company solo-jazz-theme solarized-theme vterm ivy catppuccin-theme magit evil-visual-mark-mode go-mode))
 '(prettier-js-command "/Users/nick/.nvm/versions/node/v20.16.0/bin/prettier"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
