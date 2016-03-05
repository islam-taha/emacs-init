(set 'ad-redefinition-action 'accept)
(setq package-enable-at-startup nil)
(package-initialize)

(emacs-lisp-mode)
(setq-default indent-tabs-mode nil)
(setq ns-use-srgb-colorspace nil)
(setq global-tab-width 2)
(setq auto-save-default nil)
(setq-default truncate-lines t)
(global-linum-mode t)
(tool-bar-mode -1)
(setq make-backup-files nil)
(show-paren-mode t)
(setq-default frame-maximized t)
(scroll-bar-mode -1)
(set-default-font "Monaco 11")

;; set keys for Apple keyboard, for emacs in OS X
(setq mac-command-modifier 'meta) ; make cmd key do Meta
(setq mac-option-modifier 'super) ; make opt key do Super
(setq mac-control-modifier 'control) ; make Control key do Control

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(defun my-js-mode-hook ()
  (setq-local js-indent-level 2))

(add-hook 'js-mode-hook 'my-js-mode-hook)


(setq helm-autoresize-mode t)
(display-time)

(require 'auto-compile)
(auto-compile-mode)

(require 'anzu)
(anzu-mode)

(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

(require 'git-gutter)
(global-git-gutter-mode 1)

(require 'neotree)
(global-set-key (kbd "C-x C-;") 'neotree-toggle)

(set-face-background 'git-gutter:modified "purple")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-c C-f") 'git-gutter:popup-diff)

(setq helm-autoresize-max-height 40
      helm-autoresize-min-height 20
      helm-split-window-in-side-p t)
(global-set-key (kbd "M-x") 'helm-M-x)

(require 'shackle)
(shackle-mode 1)
(setq shackle-rules '(("\\`\\*helm.*?\\*\\'" :regexp t :align t :size 0.4)
                      ("*git-gutter:diff"    :regexp t :align t :size 0.4)))

(require 'helm-fuzzier)
(helm-fuzzier-mode 1)
(setq helm-M-x-fuzzy-match 1)
(setq helm-mode-fuzzy-match 1)
(setq helm-apropos-fuzzy-match 1)
(setq helm-buffers-fuzzy-matching 1)

(require 'multiple-cursors)
(global-set-key (kbd "C-c C-c") 'mc/edit-lines)
(global-set-key (kbd "C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-,") 'mc/mark-all-like-this)

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-p") 'helm-projectile)

(require 'web-mode)
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-tag-auto-close-style t)


(desktop-save-mode 1)
(ido-mode 1)
(setq-default flx-ido-mode 1)

(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))

(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))

(add-hook 'ido-setup-hook 'ido-define-keys)

(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

(global-set-key (kbd "M-t") 'select-current-line)
(global-set-key (kbd "M-/") 'comment-region)
(global-set-key (kbd "M-S-/") 'comment-region)

(defun run-compile-current-file ()
  "Compile and run current .cpp file"
  (interactive)
  (shell-command
   (format "osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"Terminal\" to do script \"cd %s;lkj\" in front window'"
           (file-name-directory buffer-file-name))))

(defun compile-current-file ()
  "Compile the current .cpp file"
  (interactive)
  (shell-command "clang++ -std=c++11 -DDEBUG -O2 *.cpp"))

(defun comment-current-line ()
  "Comment the current line"
  (interactive)
  (select-current-line)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key (kbd "M-r") 'run-compile-current-file)
(global-set-key (kbd "M-b") 'compile-current-file)
(global-set-key (kbd "M-/") 'comment-current-line)
(global-set-key (kbd "C-v") 'next-buffer)
(global-set-key (kbd "M-v") 'previous-buffer)

(setq visible-bell nil)
(setq ring-bell-function (lambda () (message "*beep*")))

;; (add-to-list 'load-path "~/.emacs.d/elpa/company-20160120.1225");
(require 'company)
(global-company-mode t)
(setq company-idle-delay 0)
(add-to-list 'company-backends 'company-tern)
(setq company-minimum-prefix-length 2)
(add-hook 'ruby-mode-hook 'robe-mode)
(push 'company-robe company-backends)
(setq company-dabbrev-downcase t)

(add-to-list 'load-path "~/.emacs.d/vendor/emacs-pry")
(require 'pry)

(require 'inf-ruby)
(setenv "PAGER" (executable-find "cat"))

;; (setq inf-ruby-default-implementation "pry")
;; (add-to-list 'inf-ruby-implementations '("pry" . "pry"))
;; (setq inf-ruby-eval-binding "pry")

(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(require 'spaceline-config)
(spaceline-spacemacs-theme)

(set-face-attribute 'mode-line nil :box nil)
(setq powerline-default-separator 'utf-8)

(define-key global-map (kbd "C-c ;") 'iedit-mode)

(global-set-key (kbd "M-_") 'windresize)

(global-set-key [M-up] (lambda () (interactive) (scroll-up 1)))
(global-set-key [M-down] (lambda () (interactive) (scroll-down 1)))

(global-set-key (kbd "C-x C-n") 'linum-mode)


(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq locale-coding-system 'utf-8)

(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

(setq display-battery-mode t)

(setq display-time-24hr-format t)

(setq display-time-default-load-average nil)

(font-lock-add-keywords 'c++-mode
                        '(("\\(\\w+\\)\\s-*\("
                           (1 font-lock-builtin-face))) t)
(font-lock-add-keywords 'c-mode
                        '(("\\(\\w+\\)\\s-*\("
                           (1 font-lock-builtin-face))) t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(ansi-term-color-vector
   [default term-color-black term-color-red term-color-green term-color-yellow term-color-blue term-color-magenta term-color-cyan term-color-white] t)
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (leuven)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "aa87469691932ff791f966bffb885ecd97ebfa4dc4d42e479f3819ac4a3fbcaf" "11bfbaeb7c000f1e0792c664c8c948eeb896a771cb1aa19121c7ee01ad4e612b" "c70cc9c4c6257d70f5c11b90cb9e8b1e54e6edd6aa43f39879746e16a70533f5" "9567c8b113a53efdf4e7f3ab47564cb44b27ee231ece20811bb191698b1b8b6b" "101a10b15bbbd0d5a0e56e4773e614962197886780afb2d62523a63a144ad96c" "1d6a2b8d5719875cd5f268ea4c2d4a24254122f9c63619b45d82404dd7359951" "43aeadb0c8634a9b2f981ed096b3c7823c511d507a51c604e4667becb5ef6e35" "64da9a8dba17dcf210420875eba3f1a5ea6272217dc403706e4e2c985aa537fa" "e254f8e18ba82e55572c5e18f3ac9c2bd6728a7e500f6cc216e0c6f6f8ea7003" "f1a6cbc40528dbee63390fc81da426f1b00b4fc09a60fe35752f5838b12fbe0a" "03e3e79fb2b344e41a7df897818b7969ca51a15a67dc0c30ebbdeb9ea2cd4492" "0ae52e74c576120c6863403922ee00340a3bf3051615674c4b937f9c99b24535" "50e7f9d112e821e42bd2b8410d50de966c35c7434dec12ddea99cb05dd368dd8" "39e93a10eb292941640adfe28509e0c3eeb84e30cbfed6ef9841be136081ca34" "e1551b5516e0a439b6ab019ba00cee866e735f66f22ff67a5d882ad0f1383454" "df7dd02705b5868a4bf38069d3b5335412b8210cabfbcd86860cea3b19ba2a3d" "2162da67ce86c514aff010de1b040fb26663ca42afebc2de26515d741121c435" "abb628b7ecdc570350db589ea22f8ae0f4b9e5304ea313532acbb84d703eecbd" "b1bcb837df0455af8e91114b7a3bddfa084cde32ceb16b1b468d5e5e8605a835" "b3ce6fadd85126d247b72d4ed9ac4d2bb43c0e0fd1605008cafd54185f30b7eb" "930227e22122d1881db7c2c1ae712dcf715697a1c4d9864f8107a2c3c2da9f8b" "2f4afdef79a7f8a6b54f7e70959e059d7e09cf234d412662e0897cacd46f04b4" "d69a0f6d860eeff5ca5f229d0373690782a99aee2410a3eed8a31332a7101f1e" "7c1e99f9d46c397b3fd08c7fdd44fe47c4778ab69cc22c344f404204eb471baa" "0bd7a42bd443517e5e61dac3cabc24018fbd0c6b2b4199b3c4efd9e3727efd30" "a17f246690840fcf3fc26cb845ffedd2d8e1161cae386c14df61dabb9af3a5a9" "d5aac94c0051c3acec2b274347b343372b4e64c3e226be7b7c56725ea26b1ba8" "bcd39b639704f6f28ab61ad1ac8eb4625be77d027b4494059e8ada22ce281252" "aed73c6d0afcf2232bb25ed2d872c7a1c4f1bda6759f84afc24de6a1aec93da8" "232f715279fc131ed4facf6a517b84d23dca145fcc0e09c5e0f90eb534e1680f" "a7b47876e5da7cac6f5e61cca7a040a365ca2c498823654bd4076add8edf34c5" "9e76732c9af8e423236ff8e37dd3b9bc37dacc256e42cc83810fb824eaa529b9" "b6db49cec08652adf1ff2341ce32c7303be313b0de38c621676122f255ee46db" "3a3917dbcc6571ef3942c2bf4c4240f70b5c4bc0b28192be6d3f9acd83607a24" "d1a42ed39a15a843cccadf107ee0242b5f78bfbb5b70ba3ce19f3ea9fda8f52d" "1a2b131a7844bad234832963d565097efc88111b196fb75757885c159c5f8137" "91fba9a99f7b64390e1f56319c3dbbaed22de1b9676b3c73d935bf62277b799c" "46b20113556c07c1173d99edc6609473a106c13871da8fc9acb6534224f1e3e4" "1edf370d2840c0bf4c031a044f3f500731b41a3fd96b02e4c257522c7457882e" "07840b49217157323d6ea4ccbdecc451b5989ebdc6e06cb0b4d742a141475a44" "cb18233197cedab557c70d171b511bed49cc702f428750925280090c31498bd2" "08dc5159473fa2250619880857eee06b7f4067f5f15b0ee8878c91f135cef6d5" "3f873e7cb090efbdceafb8f54afed391899172dd917bb7a354737a8bb048bd71" "e033c4abd259afac2475abd9545f2099a567eb0e5ec4d1ed13567a77c1919f8f" "b110da1a5934e91717b5c490709aba3c60eb4595194bbf9fdcbb97d247c70cfa" "db9feb330fd7cb170b01b8c3c6ecdc5179fc321f1a4824da6c53609b033b2810" "cb8039d38d197de5049bd2e0e57b0a9001d89d820c3b36c945a12d6b5198e810" "59ca830d4df5e79503b79103485d28c6a578ca14d526ffc6a43596808daf1282" "a93f214aac52d55f7f53dc95ba2ebd87814dbc812ad0750960ee4229da5c9321" "16d6e7f87846801e17e0c8abc331cf6fa55bec73185a86a431aca6bec5d28a0a" "275ed2b17e22759bed06564fddbb703c7b0893c76d17a0f353614f556c46d05e" "6916fa929b497ab630e23f2a4785b3b72ce9877640ae52088c65c00f8897d67f" "1b4243872807cfad4804d7781c51d051dfcc143b244da56827071a9c2e10ab7f" "e681c4fc684a543ce97c2d55082c6585182c0089f605dc9a5fe193870f03edc6" "c73236c58c77d76271fef510552c4c43c4c69748f4bfd900b132ad17cc065611" "82cbb553a225b75ee49901fa06562941fbfe5e6fed24cda985e7ea59af7ddc80" "5cc9df26a180d14a6c5fc47df24d05305636c80030a85cf65e31f420d7836688" "ad68cb14359254795c6b96d76334aaacb739c04f64a4a8567964d4a20aa723d2" "744c95ef0117ca34c5d4261cb00aff6750fd60338240c28501adb5701621e076" "1462969067f2ff901993b313085d47e16badeec58b63b9ed67fa660cebaaddae" "b83c1e19c912f0d84a543b37367242f8a3ad2ed3aec80f5363d0d82ba4621e7d" "e2e4e109357cfcebccb17961950da6b84f72187ade0920a4494013489df648fe" "ee3b22b48b269b83aa385b3915d88a9bf4f18e82bb52e20211c7574381a4029a" "75c0b9f9f90d95ac03f8647c75a91ec68437c12ff598e2abb22418cd4b255af0" "8704829d51ea058227662e33f84313d268b330364f6e1f31dc67671712143caf" "bf81a86f9cfa079a7bb9841bc6ecf9a2e8999b85e4ae1a4d0138975921315713" "01c5ebefcabc983c907ee30e429225337d0b4556cc1d21df0330d337275facbb" "e24679edfdea016519c0e2d4a5e57157a11f928b7ef4361d00c23a7fe54b8e01" "90b1aeef48eb5498b58f7085a54b5d2c9efef2bb98d71d85e77427ce37aec223" "d43120398682953ef18fd7e11e69c94e44d39bb2ab450c4e64815311542acbff" "3fb38c0c32f0b8ea93170be4d33631c607c60c709a546cb6199659e6308aedf7" "cdfb22711f64d0e665f40b2607879fcf2607764b2b70d672ddaa26d2da13049f" "e517a2cab05f7f6002fb80be3758ddcfa67d7b8323aa56fb50889e43457e9c1f" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "48373328e7ead33ed0161ad096c688376f65a617c3fcafd62dbfe814fff12a1e" "f21a0c90d189caf15bf1b6808336a281017b222af7401cd056fa457fbd314d96" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "fa11f855b5f606f84e50106a7360c72aac88fee5f6fb8084aa4329009b61c5a2" "49de25b465bc3c2498bcd4c1575fa0090bd56fc79cdb49b919b49eaea17ee1dd" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(display-battery-mode t)
 '(display-time-mode t)
 '(fci-rule-color "#37474f")
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "=")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-sexp-background-color "#1c1f26")
 '(linum-format " %2i ")
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(ns-use-srgb-colorspace nil)
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(powerline-default-separator (quote wave))
 '(powerline-height 20)
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(speedbar-use-tool-tips-flag t)
 '(standard-indent 2)
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(powerline-active2 ((nil))))


