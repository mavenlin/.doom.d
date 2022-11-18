;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lin Min"
      user-mail-address "linmin@sea.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq doom-theme 'doom-Iosvkem)
;;(setq doom-themes-enable-bold 'nil)


(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(add-hook! python-mode 'display-fill-column-indicator-mode)
(add-hook! python-mode 'python-indent-guess-indent-offset)
(add-hook! c++-mode 'display-fill-column-indicator-mode)
(add-hook! c++-mode (lambda () (setq flycheck-clang-language-standard "c++17"
                                     flycheck-gcc-language-standard "c++17")))

(use-package! yapfify
  :hook
  (python-mode . yapf-mode))

(after! forge
  (add-to-list 'forge-alist '("git.garena.com" "git.garena.com/api/v4" "git.garena.com" forge-gitlab-repository)))

(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(setq! mc/always-run-for-all t)

(load! "google-c-style")
(add-hook! c++-mode 'google-set-c-style)
(add-hook! c++-mode 'google-make-newline-indent)

(use-package! protobuf-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode)))

(use-package! bazel
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("BUILD\\(\\.bazel\\)?\\'" . bazel-build-mode))
  (add-to-list 'auto-mode-alist '("\\.BUILD\\'" . bazel-build-mode))
  (add-to-list 'auto-mode-alist '("\\.bzl\\'" . bazel-starlark-mode))
  (add-to-list 'auto-mode-alist '("WORKSPACE\\'" . bazel-workspace-mode))
  :config
  (setq bazel-buildifier-before-save t)
  (appendq! +format-on-save-enabled-modes '(bazel-mode)))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))
