(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "nil" :slant normal :weight normal :height 110 :width normal)))))
(put 'erase-buffer 'disabled nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default auto-save-mode nil)
(setq-default truncate-lines 1)
(setq-default linum-mode t)
(setq-default tool-bar-mode nil)
(setq-default make-backup-files nil)
(setq-default show-paren-mode t)
(setq-default frame-maximized t)
(setq-default scroll-bar nil)
;; set keys for Apple keyboard, for emacs in OS X
(setq mac-command-modifier 'meta) ; make cmd key do Meta
(setq mac-option-modifier 'super) ; make opt key do Super
(setq mac-control-modifier 'control) ; make Control key do Control

(global-set-key [M-up] (lambda () (interactive) (scroll-up 1)))
(global-set-key [M-down] (lambda () (interactive) (scroll-down 1)))

(global-set-key (kbd "C-x C-n") 'linum-mode)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

; list the packages you want
(setq package-list '(adaptive-wrap airline-themes powerline auto-complete popup color-theme-modern darcula-theme ecb find-file-in-project swiper flx-ido flx flymake-ruby flymake-easy fsm git-gutter iedit mark-multiple mmm-mode multiple-cursors popup powerline solarized-theme dash swiper tommyh-theme twilight-bright-theme zenburn-theme))

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(add-hook 'html-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 4)
            (setq html-indent 4)))


(setq gnus-select-method '(nnml ""))

(setq display-time-24hr-format t)

(setq display-time-default-load-average nil)

;; refresh conversation list every minute
(add-hook 'hangups-mode-hook (lambda () (run-with-timer 120 (* 1 60) 'hangups-list-refresh)))

;; set base display string
(setq display-time-string-forms
      '(" " 24-hours ":" minutes " "))

;; add to the display-string the number of unread messages
(setq display-time-string-forms
      (append
       display-time-string-forms
       '((if (boundp 'hangups/convs-unread)
             (propertize
              (concat "Texts(" (int-to-string hangups/convs-unread) ")") ;; surround the number by "Texts()"
              'font-lock-face '(:background "black" :foreground "white")))))) ;; what the font style should be

;; display the time
(display-time-mode)

(add-to-list 'custom-theme-load-path "~/themes")
(add-to-list 'load-path "/Users/Tensor/hangups.el/")
(require 'hangups)
;; (add-to-list 'load-path "~/cfparser")
;; (require 'cf-mode)
;; (add-hook 'find-file-hook 'cf-mode)
;; (setq cf-test-command
;;       (concat
;;        "clang++ *.cpp -std=c++11 -O2; "
;;        "for i in `ls *.in | sed 's/.in//'`; do "
;;        "echo test $i; "
;;        "./a.out < $i.in | diff - $i.out; "
;;        "done;"))
;; (setq cf-test-command
;;       (format "osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"Terminal\" to do script \"cd %s; %s\" in front window'"
;;               (file-name-directory buffer-file-name) testing-cmd))

;;; activate ecb
(require 'ecb)
;;(require 'ecb-autoloads)
(global-set-key (kbd "C-x C-;") 'ecb-activate)
(global-set-key (kbd "C-x C-'") 'ecb-deactivate)
;;; show/hide ecb window
(global-set-key (kbd "C-;") 'ecb-show-ecb-windows)
(global-set-key (kbd "C-'") 'ecb-hide-ecb-windows)
;;; quick navigation between ecb windows
(global-set-key (kbd "C-0") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-1") 'ecb-goto-window-directories)
(global-set-key (kbd "C-2") 'ecb-goto-window-sources)
(global-set-key (kbd "C-3") 'ecb-goto-window-methods)
(global-set-key (kbd "C-4") 'ecb-goto-window-compilation)

(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))

(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))

(add-hook 'ido-setup-hook 'ido-define-keys)

;; (add-hook 'projectile-mode-hook 'projectile-rails-on)
;; (add-hook 'ruby-mode-hook 'projectile-on)
(desktop-save-mode 1)
(ido-mode 1)
(setq-default flx-ido-mode 1)

(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

(global-set-key (kbd "M-t") 'select-current-line)
(global-set-key (kbd "M-/") 'comment-region)
(global-set-key (kbd "M-S-/") 'comment-region)

 ;; (setq jabber-account-list
 ;;    '(("islamtaha53@gmail.com" 
 ;;       (:network-server . "talk.google.com")
 ;;       (:connection-type . starttls)
 ;;       (:password . "yasminemousa")
 ;;       (:port . 443))))

(defun jabber ()
  (interactive)
  (jabber-connect)
  (switch-to-buffer "*-jabber-*"))

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

(define-key global-map (kbd "C-c ;") 'iedit-mode)
(global-set-key (kbd "M-p") 'ffip)

;; (semantic-mode 1)
;; ; let's define a function which adds semantic as a suggestion backend to auto complete
;; ; and hook this function to c-mode-common-hook
;; (defun my:add-semantic-to-autocomplete() 
;;   (add-to-list 'ac-sources 'ac-source-semantic)
;; )
;; (add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
;; ; turn on ede mode 
;; (global-ede-mode 1)
;; (global-semantic-idle-scheduler-mode 1)

;; (add-to-list 'load-path "~/.emacs.d/elpa/company-0.8.12")
;; (autoload 'company-mode "company" nil t)
;; (require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)
;; (setq company-backends (delete 'company-semantic company-backends))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(ansi-term-color-vector
   [unspecified "#FFFFFF" "#d15120" "#5f9411" "#d2ad00" "#6b82a7" "#a66bab" "#6b82a7" "#505050"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (airline-simple)))
 '(custom-safe-themes
   (quote
    ("ff91126a04828db24ae38ebd1988cf0bce021ebadb6c5d9659b01975f9474d0f" "7d468f9816c7265512390e6a2d8da5a947f708585556bedbb6d006b183b9adea" "3a5335eb85f03305f7ca73edcacb4f4102433b1cec3b84b145a941a464154800" "01ac9b522874a4ab5c64548ccd93f67456cf71f0622064554f770df736529108" "c9f25ae243704c7d503e9a15f5b28e56c08fa05fc4627692685059e54641c2d8" "4dde0d5724fe8c2b00e738bf7c5ba67af854648aeeceb67e0f8d68b78553f918" "7bc91918cb4a7720cc449b2538ae5cc6d0428c512c612a5dba30c9ce8b2a303d" "25c89b2741e501c6af04167cf8ad16673360f6c16e8da506adb5f5fabfa38bbd" "15ba1f25c4b1538985612a8063cad16ffecc40acb7a992dd7fdfc063e3378886" "fcdc7d2619b8f4a65e7d47d842e2c90756130ddfe62ec1f27955f22f77d46ea1" "03226d3ed2ec63f60f73c32663a56a41f0b1541ab3043b1a1d0927e3c5e2d0dd" "d6d9748adfb4ec59461f76bf92725624169455e3027d19ff5b0adc297de6b477" "71213ba08e8101b4f741f4169347b9a87e700c8a04dffa420fa4e2d50cc8521f" "ab99b1ce5723ab31c1212e4dca8f5fbb01fee7ca0f7938d2fad760d2656bd352" "a5b2eddb23cf61d2572a64733efd0d80378986aa9ac4a4be8d36a3a6ef50e5cb" "dd3eb539595bd7643baaff3a3be67b735a82052c37c2d59192ef51a0983dbfca" "0ae977e603e99d89c80d679377bfed4a904317968bd885ee063455cee01728d3" "2cc9ecf74dd307cdf856a2f47f6149583d6cca9616a0f4ecc058bafa57e4ffa3" "60e97fc4cdb64c43cab637cd0027e09cf27939fe799a1889a30cfedd6f2e7f8e" "7a83132ecb08e86c63d3cbf4b677d4cb1bcfcfb47f4942f2b8ecc7f6ebc2004c" "bb6b64bfb2f63efed8dea1ca03691c07c851a8be6f21675fe4909289d68975d9" "ab91ad83f4c9e12a8d01458e83954fd244541eb9412c87d1ab831629c47ad504" "234249a92c2cf7b61223d9f83e1d9eefcd80fcf6b7a5e9ca03dc9d3f1b122ae2" "17a8fa9430ffd81f242ed3ee95e59629ccf9e1210657536013a0def9b16e68c9" "a1493957ee779057acdc4c337133f217dd7b2edfdeeffed903ba2f16246f665a" "64c60102b3f704d8ecf38205380f6b1b83e200561abb32f787d4937f788fc328" "c9445e1f0bd72e79e35f3e6f04c22ccf37e3a187a8e5581b84e8ea8116fe0912" "cfd79d66fe6b142b570048ed9a28cd2c71876f824d76e1d9f2da0f3353062f3f" "701b4b4e7989329a0704b92fc17e6600cc18f9df4f2466617ec91c932b5477eb" "9bc1eec9b485726318efd9341df6da8b53fa684931d33beba57ed7207f2090d6" "5cd698ce53179b1e4eaa7917c992832a220600c973967904fea71e3980a46532" "418e15103f9345a289985f6cf63c35ad9732bff6624f38b4672a942c3a6fe354" "4266ac847ba36aa589514aed732de02fe83801ef12e2118f7a65a4a46e20af96" "3a0248176bf115cd53e0f15e30bb338b55e2a09f1f9508794fcd3c623725c8bd" "b48599e24e6db1ea612061252e71abc2c05c05ac4b6ad532ad99ee085c7961a7" "8d1baba3bbafc11628972b5b0a4453b5120be4fb8d30ad0ca4b35d114422dd65" "d422c7673d74d1e093397288d2e02c799340c5dabf70e87558b8e8faa3f83a6c" "cc2f32f5ee19cbd7c139fc821ec653804fcab5fcbf140723752156dc23cdb89f" "008775b6f17cba84b22da8c820d9c6778fac161291f1a9cc252a7e735714bc56" "f2355ec455645cd4a4b8f8ac8bcb96c50bc8f383634e59307d8bc651143f6be4" "9db75254c21afb1ab22cb97a3ac39ccbbd680ef31197605fd5f312e91d84c08c" "73e09ba6f23a9b3aeedb3ee8589da74182b644c169daa62c4454eac73eea610a" "adbe7ba38c551281f21d760de0840cab0e1259964075a7e46cc2b9fdea4b82d6" "aa95b9a243de8c18230ed97315c737ceba2c8ebda8cff997d35b4c2fab5ba007" "71373650950508e648f86e3d1e4a449a859aeb6d8cf791833d9104715d5943a3" "80ee5b0e403162518b90236ba7c31c4f29192c451ad124097f31166c038f2523" "822ee0a190e234546687e145e4fa97c858195023c595ea57878e59e06b25b6e6" "3b4800ea72984641068f45e8d1911405b910f1406b83650cbd747a831295c911" "a427ba34c9edff7a5d7a34ecce1e9fc42ac19db18564017a7231ec57c19cde4e" "beeb4fbb490f1a420ea5acc6f589b72c6f0c31dd55943859fc9b60b0c1091468" "4f66410c3d3434129e230eaab99f9319bd5871623689fb56713e38255eb16ddc" "d251c0f968ee538a5f5b54ed90669263f666add9c224ad5411cfabc8abada5a0" "06a610f234492f78a6311304adffa54285b062b3859ad74eb13ca5d74119aef9" "5668fbb51b7467f6a49055b0ba80b54f8998c6a98a267465ec44618db4ab99eb" "d5d41f830f46af348112e869fbdc66315b560d7f8da55c7b067269f890d28911" "0058b7d3e399b6f7681b7e44496ea835e635b1501223797bad7dd5f5d55bb450" "ad97202c92f426a867e83060801938acf035921d5d7e78da3041a999082fb565" "c3806e9426f97f54eccd51bb90c1fabb9205bf359d9ab23311638e1a68aae472" "7ec6a9707c69e7a4ea1a8761b3f28f8dc55c6c5cacd597718c994b1561e435f3" "55573f69249d1cfdd795dacf1680e56c31fdaab4c0ed334b28de96c20eec01a3" "ec0c9d1715065a594af90e19e596e737c7b2cdaa18eb1b71baf7ef696adbefb0" "47e37fa090129214330d13a68549d5c86ccc2c41f4979cb4be130ff945a9859a" "bbb51078321186cbbbcb38f9b74ea154154af10c5d9c61d2b0258cb4401ac038" "d5ecb1ae85bb043a10b8c9f10b40118c9b97806c73410c402340f89abbba8ebb" "87818a78deaefd55594bb4fef802fb4948989996c12f8e0e609c46c6bd038edf" "c1af7190a6855a376f7a7563445687064af6d8bdca423136cb013c93fbfd1b00" "0ff3aeed353697992d100ddf8a94d065a58ffbde5a40afefa605f211757c8ab0" "70b9e0d0b857d6497c6623bb360a3a7f915251c4a6233c30b65f9005eb9f4256" "1faffcddc50d5dc7d334f2817dd6f159ef1820be3aad303eb7f74006531afdff" "fa7b1e3a0bfc7097e9da2f202258897cc6db3fef38d0095881e59a4446ac7d6f" "31ba13fd560daff5b05e11d4be7d280213249225e85969ec5bc71532e788ee81" "81df5c7887aaa76c0174ae54aacd20ab18cc263b95332b09efa0d60a89feaf6a" "8e997c790c6b22c091edb8a866f545857eaae227a0c41df402711f6ebc70326c" "2588175e0f3591583582a72c465e6d38bd8c99b36daee949ab08f1e758052117" "31772cd378fd8267d6427cec2d02d599eee14a1b60e9b2b894dd5487bd30978e" "98e5e942303b4f356d6573009c96087f9b872f2fa258c673188d913f6faf17ea" "ef36e983fa01515298c017d0902524862ec7d9b00c28922d6da093485821e1ba" "fd7ef8af44dd5f240e4e65b8a4eecbc37a07c7896d729a75ba036a59f82cfa58" "3ddfde8b6afe9a72749b73b021ffd5a837f6b9d5c638f7c16d81ec9d346d899f" "e008d9149dd39b249d4f8a9b5c1362d8f85bd11e9c08454e5728fbf0fcc11690" "2c50bf38069a99a18404275e8d139a8a1019a629dab4be9b92b8d5d9c43bbb92" "a405a0c2ec845e34ecb32a83f477ca36d1858b976f028694e0ee7ff4af33e400" "0ca71d3462db28ebdef0529995c2d0fdb90650c8e31631e92b9f02bd1bfc5f36" "cedc71ca0adde34902543489952ebe6fde33b185a690a6f29bcaaefd6ec13fd8" "caa9a86ff9b85f733b424f520ec6ecff3499a36f20eb8d40e3096dbbe1884069" "073ddba1288a18a8fb77c8859498cf1f32638193689b990f7011e1a21ed39538" "a3821772b5051fa49cf567af79cc4dabfcfd37a1b9236492ae4724a77f42d70d" "b42cf9ee9e59c3aec585fff1ce35acf50259d8b59f3047e57df0fa38516aa335" "2d8569fc9eb766b0be02d3f7fbb629bcd26fe34f5d328497e1fc1ddcfd5126b9" "57d7e8b7b7e0a22dc07357f0c30d18b33ffcbb7bcd9013ab2c9f70748cfa4838" "6394ba6170fd0bc9f24794d555fa84676d2bd5e3cfd50b3e270183223f8a6535" "f07583bdbcca020adecb151868c33820dfe3ad5076ca96f6d51b1da3f0db7105" "09feeb867d1ca5c1a33050d857ad6a5d62ad888f4b9136ec42002d6cdf310235" "9a3c51c59edfefd53e5de64c9da248c24b628d4e78cc808611abd15b3e58858f" "9dc64d345811d74b5cd0dac92e5717e1016573417b23811b2c37bb985da41da2" "6cf0e8d082a890e94e4423fc9e222beefdbacee6210602524b7c84d207a5dfb5" "f831c1716ebc909abe3c851569a402782b01074e665a4c140e3e52214f7504a0" "89127a6e23df1b1120aa61bd7984f1d5f2747cad1e700614a68bdb7df77189ba" "6ecfc451f545459728a4a8b1d44ac4cdcc5d93465536807d0cb0647ef2bb12c4" "50d8de7ef10b93c4c7251888ff845577004e086c5bfb2c4bb71eca51b474063a" "b39af5ef9cfc7d460bd3659d26731effa17799127d6916c4d85938dda650d4b0" "4974f680cd265a7049d7bfbb9be82e78ae97c12dd5eac0205756acc3f424f882" "6981a905808c6137dc3a3b089b9393406d2cbddde1d9336bb9d372cbc204d592" "eb399cbd3ea4c93d9ab15b513fd6638e801600e13c8a70b56f38e609397a5eca" "af4cfe7f2de40f19e0798d46057aae0bccfbc87a85a2d4100339eaf91a1f202a" "929744da373c859c0f07325bc9c8d5cc30d418468c2ecb3a4f6cb2e3728d4775" "c712d616ea5a9ef4e513681846eb908728bbb087c2d251ded8374ee9faafa199" "6e03b7f86fcca5ce4e63cda5cd0da592973e30b5c5edf198eddf51db7a12b832" "2fc7672758572337a2c9d748d8f53cc7839244642e4409b375baef6152400b4d" "3fe4861111710e42230627f38ebb8f966391eadefb8b809f4bfb8340a4e85529" "5562060e16ae3188e79d87e9ba69d70a6922448bcc5018205850d10696ed0116" "989b6cb60e97759d7c45d65121f43b746aff298b5cf8dcf5cfd19c03830b83e9" "fc89666d6de5e1d75e6fe4210bd20be560a68982da7f352bd19c1033fb7583ba" "551f0e9d6bfc26370c91a0aead8d6579cdedc70c2453cb5ef87a90de51101691" "549c1c977a8eea73021ca2fcc54169d0b2349aaee92d85b6f35e442399cbb61b" "0c5204945ca5cdf119390fe7f0b375e8d921e92076b416f6615bbe1bd5d80c88" "39a854967792547c704cbff8ad4f97429f77dfcf7b3b4d2a62679ecd34b608da" "6c57adb4d3da69cfb559e103e555905c9eec48616104e217502d0a372e63dcea" "0f0adcd1352b15a622afd48fcff8232169aac4b5966841e506f815f81dac44ea" "f34690262d1506627de39945e0bc2c7c47ece167edea85851bab380048dc8580" "f211f8db2328fb031908c9496582e7de2ae8abd5f59a27b4c1218720a7d11803" "2c73700ef9c2c3aacaf4b65a7751b8627b95a1fd8cebed8aa199f2afb089a85f" "2f4afdef79a7f8a6b54f7e70959e059d7e09cf234d412662e0897cacd46f04b4" "d69a0f6d860eeff5ca5f229d0373690782a99aee2410a3eed8a31332a7101f1e" "7c1e99f9d46c397b3fd08c7fdd44fe47c4778ab69cc22c344f404204eb471baa" "a17f246690840fcf3fc26cb845ffedd2d8e1161cae386c14df61dabb9af3a5a9" "bcd39b639704f6f28ab61ad1ac8eb4625be77d027b4494059e8ada22ce281252" "aed73c6d0afcf2232bb25ed2d872c7a1c4f1bda6759f84afc24de6a1aec93da8" "232f715279fc131ed4facf6a517b84d23dca145fcc0e09c5e0f90eb534e1680f" "a7b47876e5da7cac6f5e61cca7a040a365ca2c498823654bd4076add8edf34c5" "9e76732c9af8e423236ff8e37dd3b9bc37dacc256e42cc83810fb824eaa529b9" "b6db49cec08652adf1ff2341ce32c7303be313b0de38c621676122f255ee46db" "3a3917dbcc6571ef3942c2bf4c4240f70b5c4bc0b28192be6d3f9acd83607a24" "d1a42ed39a15a843cccadf107ee0242b5f78bfbb5b70ba3ce19f3ea9fda8f52d" "1a2b131a7844bad234832963d565097efc88111b196fb75757885c159c5f8137" "91fba9a99f7b64390e1f56319c3dbbaed22de1b9676b3c73d935bf62277b799c" "46b20113556c07c1173d99edc6609473a106c13871da8fc9acb6534224f1e3e4" "1edf370d2840c0bf4c031a044f3f500731b41a3fd96b02e4c257522c7457882e" "07840b49217157323d6ea4ccbdecc451b5989ebdc6e06cb0b4d742a141475a44" "cb18233197cedab557c70d171b511bed49cc702f428750925280090c31498bd2" "08dc5159473fa2250619880857eee06b7f4067f5f15b0ee8878c91f135cef6d5" "76659fd7fc5ce57d14dfb22b30aac6cf0d4eb0a279f4131be3945d3cfff10bc6" "abb628b7ecdc570350db589ea22f8ae0f4b9e5304ea313532acbb84d703eecbd" "50e7f9d112e821e42bd2b8410d50de966c35c7434dec12ddea99cb05dd368dd8" "0ae52e74c576120c6863403922ee00340a3bf3051615674c4b937f9c99b24535" "03e3e79fb2b344e41a7df897818b7969ca51a15a67dc0c30ebbdeb9ea2cd4492" "f1a6cbc40528dbee63390fc81da426f1b00b4fc09a60fe35752f5838b12fbe0a" "e254f8e18ba82e55572c5e18f3ac9c2bd6728a7e500f6cc216e0c6f6f8ea7003" "64da9a8dba17dcf210420875eba3f1a5ea6272217dc403706e4e2c985aa537fa" "43aeadb0c8634a9b2f981ed096b3c7823c511d507a51c604e4667becb5ef6e35" "1d6a2b8d5719875cd5f268ea4c2d4a24254122f9c63619b45d82404dd7359951" "101a10b15bbbd0d5a0e56e4773e614962197886780afb2d62523a63a144ad96c" "9567c8b113a53efdf4e7f3ab47564cb44b27ee231ece20811bb191698b1b8b6b" "c70cc9c4c6257d70f5c11b90cb9e8b1e54e6edd6aa43f39879746e16a70533f5" "11bfbaeb7c000f1e0792c664c8c948eeb896a771cb1aa19121c7ee01ad4e612b" "aa87469691932ff791f966bffb885ecd97ebfa4dc4d42e479f3819ac4a3fbcaf" "2c73253d050a229d56ce25b7e5360aa2f7566dfd80174da8e53bd9d3e612a310" "9f6750057fefba39c184783c7b80ddd9c63bc6e8064846b423b4362c9e930404" "479f188da96dcf244be270724c23de58607c031626bde8ba8243799f209d16b1" "06fc6014871028d24b4e03db24b9efee48bd73dce0afdc15e9124f09fab64afa" "36012edb5bc7070a17e989984e0ecc1d1e9c94326bdd0fbd76c2a45ebfe7da54" "890d09dcc8d2326e98eee74b307b2cc42f07ab7701bcff521e6152aa3e08f7a8" "2f8c57e0f449547a9fd89a49220491d88e2facd7756c49b70fead256d37fd4fa" "9e87bddff84cbce28c01fa05eb22f986d770628fa202cd5ca0cd7ed53db2f068" "21e380db38e92e8c0e56e0a2446f7ac8f6851061b57ffbcadb284ffe4c102478" "b4ec581daad15aa7020b722523dc6bcea850bfbdbe31bfeb11c45ea51899bd75" "a922c743710bb5d7c14995345549141f01211ff5089057dc718a5a33104c3fd1" "e8e744a1b0726814ac3ab86ad5ccdf658b9ff1c5a63c4dc23841007874044d4a" "7e346cf2cb6a8324930c9f07ce050e9b7dfae5a315cd8ed3af6bcc94343f8402" "f2503f0a035c2122984e90eb184185769ee665de5864edc19b339856942d2d2d" "5424f18165ed7fd9c3ec8ea43d801dc9c71ab9da2b044000162a47c102ef09ea" "e8bba3c8e8caea2c7a8b6932b0db8d9bdb468c9b44bf554f37b56093d23fde57" "f245c9f24b609b00441a6a336bcc556fe38a6b24bfc0ca4aedd4fe23d858ba31" "b2028956188cf668e27a130c027e7f240c24c705c1517108b98a9645644711d9" "0b6645497e51d80eda1d337d6cabe31814d6c381e69491931a688836c16137ed" "8e0781b24291a7b29a411ba29ed01c8c2ee696c03c3dfdb3c3e89f8655db78ed" "76bd62f6ce376bf0597fab7f478eaa98cd94a7b41f0ae46de63a958fbe99c1d9" "c55d8474e898e1231c49547d50e15d05c387e4111f4085f5fb7120a7418165c2" "09669536b4a71f409e7e2fd56609cd7f0dff2850d4cbfb43916cc1843c463b80" "8ffaf449297bd9a08517f4b03a4df9dbf3e347652746cefceb3ee57c8e584b9f" "294834baa9ca874795a3181cce7aaf228b1e3fb3899587ffd3ae7546de328c90" "b6d649c9f972b491686e7fa634535653e6222c1faca1ab71b3117854470a79ae" "f21caace402180ab3dc5157d2bb843c4daafbe64aadc362c9f4558ac17ce43a2" "6ae93caf30ad7eef728589a4d7b7befadecade71d78b904a64a0480608a7b61e" "8e3f020f1ce69cfa0c1ebee4e198feb28dd7eb31b7d77927e9c790819210c654" "3f873e7cb090efbdceafb8f54afed391899172dd917bb7a354737a8bb048bd71" "e033c4abd259afac2475abd9545f2099a567eb0e5ec4d1ed13567a77c1919f8f" "b110da1a5934e91717b5c490709aba3c60eb4595194bbf9fdcbb97d247c70cfa" "db9feb330fd7cb170b01b8c3c6ecdc5179fc321f1a4824da6c53609b033b2810" "275ed2b17e22759bed06564fddbb703c7b0893c76d17a0f353614f556c46d05e" "6916fa929b497ab630e23f2a4785b3b72ce9877640ae52088c65c00f8897d67f" "1b4243872807cfad4804d7781c51d051dfcc143b244da56827071a9c2e10ab7f" "e681c4fc684a543ce97c2d55082c6585182c0089f605dc9a5fe193870f03edc6" "c73236c58c77d76271fef510552c4c43c4c69748f4bfd900b132ad17cc065611" "82cbb553a225b75ee49901fa06562941fbfe5e6fed24cda985e7ea59af7ddc80" "5cc9df26a180d14a6c5fc47df24d05305636c80030a85cf65e31f420d7836688" "ad68cb14359254795c6b96d76334aaacb739c04f64a4a8567964d4a20aa723d2" "744c95ef0117ca34c5d4261cb00aff6750fd60338240c28501adb5701621e076" "1462969067f2ff901993b313085d47e16badeec58b63b9ed67fa660cebaaddae" "b83c1e19c912f0d84a543b37367242f8a3ad2ed3aec80f5363d0d82ba4621e7d" "e2e4e109357cfcebccb17961950da6b84f72187ade0920a4494013489df648fe" "ee3b22b48b269b83aa385b3915d88a9bf4f18e82bb52e20211c7574381a4029a" "75c0b9f9f90d95ac03f8647c75a91ec68437c12ff598e2abb22418cd4b255af0" "8704829d51ea058227662e33f84313d268b330364f6e1f31dc67671712143caf" "bf81a86f9cfa079a7bb9841bc6ecf9a2e8999b85e4ae1a4d0138975921315713" "01c5ebefcabc983c907ee30e429225337d0b4556cc1d21df0330d337275facbb" "e24679edfdea016519c0e2d4a5e57157a11f928b7ef4361d00c23a7fe54b8e01" "90b1aeef48eb5498b58f7085a54b5d2c9efef2bb98d71d85e77427ce37aec223" "d43120398682953ef18fd7e11e69c94e44d39bb2ab450c4e64815311542acbff" "3fb38c0c32f0b8ea93170be4d33631c607c60c709a546cb6199659e6308aedf7" "cdfb22711f64d0e665f40b2607879fcf2607764b2b70d672ddaa26d2da13049f" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "8855d6dbd8b4ea5d87146dc77ba1b8b7f06142ee8107429f0520c38777d9b39e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "b5fe3893c8808466711c1b55bb7e66b9c6aa2a86811783375a43e1beabb1af33" "b869a1353d39ab81b19eb79de40ff3e7bb6eaad705e61f7e4dbdcb183f08c5a6" "0aca3a26459bbb43a77f34bc22851c05c0a5d70d3230cbcdbda4fec20fef77e6" "a0bbe4dc3513cbd049eb95f79c467b6f19dc42979fec27a0481bb6980bd8d405" "aab598c4d024d544b4e8b356a95ca693afa9de000b154bd2f86eed68c9e75557" "8c75217782ccea7e9f3ad2dae831487a5fb636d042263d0a0e0438d551da3224" "e8586a76a96fd322ccb644ca0c3a1e4f4ca071ccfdb0f19bef90c4040d5d3841" "51277c9add74612c7624a276e1ee3c7d89b2f38b1609eed6759965f9d4254369" "977513781c8dd86f4f0a04dbf518df5ba496da42b71173368b305478703eea42" "6998bd3671091820a6930b52aab30b776faea41449b4246fdce14079b3e7d125" "0788bfa0a0d0471984de6d367bb2358c49b25e393344d2a531e779b6cec260c5" "cadc97db0173a0d0bfc40473cab4da462af0ba8d60befd0a4879b582bcbc092d" "9864c2e956c25b3098fbc935ba0969e333dd74ecd7a1013c8dd39a6c171e1cca" "e87a2bd5abc8448f8676365692e908b709b93f2d3869c42a4371223aab7d9cf8" "70340909b0f7e75b91e66a02aa3ad61f3106071a1a4e717d5cdabd8087b47ec4" "878e22a7fe00ca4faba87b4f16bc269b8d2be5409d1c513bb7eda025da7c1cf4" "86a731bda96ed5ed69980b4cbafe45614ec3c288da3b773e4585101e7ece40d2" "133222702a3c75d16ea9c50743f66b987a7209fb8b964f2c0938a816a83379a0" "d9a0d14596e3d0bdb81f052fa9b99741dcd239af402d42e35f80822e05557cb2" "304c03c9cfcd368b4ab0832357788cd48513fe1bd89b9e531dd47886a83405a1" "8f0334c430540bf45dbcbc06184a2e8cb01145f0ae1027ce6b1c40876144c0c9" "fbcdb6b7890d0ec1708fa21ab08eb0cc16a8b7611bb6517b722eba3891dfc9dd" "532769a638787d1196bc22c885e9b85269c3fc650fdecfc45135bb618127034c" "2a5be663818e1e23fd2175cc8dac8a2015dcde6b2e07536712451b14658bbf68" "f9d34593e9dd14b2d798494609aa0fddca618145a5d4b8a1819283bc5b7a2bfd" "8e7ca85479dab486e15e0119f2948ba7ffcaa0ef161b3facb8103fb06f93b428" "beeb5ac6b65fcccfe434071d4624ff0308b5968bf2f0c01b567d212bcaf66054" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "4f5bb895d88b6fe6a983e63429f154b8d939b4a8c581956493783b2515e22d6d" "12b4427ae6e0eef8b870b450e59e75122d5080016a9061c9696959e50d578057" "ad950f1b1bf65682e390f3547d479fd35d8c66cafa2b8aa28179d78122faa947" "790e74b900c074ac8f64fa0b610ad05bcfece9be44e8f5340d2d94c1e47538de" "98a619757483dc6614c266107ab6b19d315f93267e535ec89b7af3d62fb83cad" "4904daa168519536b08ca4655d798ca0fb50d3545e6244cefcf7d0c7b338af7e" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "9b402e9e8f62024b2e7f516465b63a4927028a7055392290600b776e4a5b9905" "f25c30c1de1994cc0660fa65c6703706f3dc509a342559e3b5b2102e50d83e4f" "d46b5a32439b319eb390f29ae1810d327a2b4ccb348f2018b94ff22f410cb5c4" "19ba41b6dc0b5dd34e1b8628ad7ae47deb19f968fe8c31853d64ea8c4df252b8" "724480fd47ebedb8b70630d5af292fd8aab4643e6546c9f57171a18b8b20eef2" "c1390663960169cd92f58aad44ba3253227d8f715c026438303c09b9fb66cdfb" "dba244449b15bdc6a3236f45cec7c2cb03de0f5cf5709a01158a278da86cb69b" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "2916d16e583c17bb2a1a9d231ea8ddcb3577f8cb97179eea689e91036213ff03" "bac3f5378bc938e96315059cd0488d6ef7a365bae73dac2ff6698960df90552d" "bc40f613df8e0d8f31c5eb3380b61f587e1b5bc439212e03d4ea44b26b4f408a" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "3a69621a68c2d3550a4c777ffc000e1ea66f5bc2f61112814c591e1bda3f5704" "a5ce06f368dd82a9dade9261bccf5c30e2c7415a582bbd0a9337ea9f6af9e265" "8288b9b453cdd2398339a9fd0cec94105bc5ca79b86695bd7bf0381b1fbe8147" "afc220610bee26945b7c750b0cca03775a8b73c27fdca81a586a0a62d45bbce2" "77c65d672b375c1e07383a9a22c9f9fc1dec34c8774fe8e5b21e76dca06d3b09" "cc0dbb53a10215b696d391a90de635ba1699072745bf653b53774706999208e3" "b9183de9666c3a16a7ffa7faaa8e9941b8d0ab50f9aaba1ca49f2f3aec7e3be9" "8aa76c44e80938bba9b8ddf559249b63319a4429a140ffecb1f92344db0a1420" "84122204c8cb1658da83e37b0081cbeaaec444a228ff36295642a16a96fd6b86" "7ce5ae5476aadfa57ffbfffd41c2d3f4aaa4e7f21de6646a76f10b2a7eaa105b" "935cc557b01242fc7b4d3f803902d14d1b3afae5123624a2f924255f641f7f01" "520377c32d772b19690013276eb32942593fd194ea257dc28ed5c053ff51e298" "cd540cb356cb169fa1493791bd4cbb183c5ad1c672b8d1be7b23e5e8c8178991" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "90e4b4a339776e635a78d398118cb782c87810cb384f1d1223da82b612338046" "7997e0765add4bfcdecb5ac3ee7f64bbb03018fb1ac5597c64ccca8c88b1262f" "cbb701f8659a49d93ecb816545adb8c164d36e93d16ff31bf68e603f77b305c1" "f3278046d89cd5bc16fbe006a9fdec1d20b4466f12d5e80ee7a92dd4a34ff886" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("/" "/"))))
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#9876aa" :underline
          (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832"))))
 '(fci-rule-character-color "#d9d9d9")
 '(fci-rule-color "#073642" t)
 '(fringe-mode 4 nil (fringe))
 '(gnus-logo-colors (quote ("#4c8383" "#bababa")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")) t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(jabber-account-list
   (quote
    (("islamtaha53@gmail.com"
      (:password . "yasminemousa")
      (:network-server . "talk.google.com")
      (:connection-type . starttls)))))
 '(linum-format " %7i ")
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(rainbow-identifiers-cie-l*a*b*-lightness 25)
 '(rainbow-identifiers-cie-l*a*b*-saturation 40)
 '(red "#ffffff")
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))))
