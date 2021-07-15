
;; auther by yx
;; diable mouse
(mouse-wheel-mode -1)
(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]  
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
(global-unset-key k))
(global-unset-key (kbd "<C-down-mouse-1>"))
(global-unset-key (kbd "<C-down-mouse-3>"))

;; hidden tool-bar menu-bar scroll-bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(scroll-bar-mode -1)


;; 关闭启动界面
(setq inhibit-startup-screen t)
;; set default marjor-mode 
(setq-default major-mode 'text-mode)



;; package
(setq package-archives '(("melpa" . "http://mirrors.bfsu.edu.cn/elpa/melpa/")
                         ("gnu" . "http://mirrors.bfsu.edu.cn/elpa/gnu/")
                         ("org" . "http://mirrors.bfsu.edu.cn/elpa/org/")))
(setq package-check-signature nil) ;个别时候会出现签名校验失败

(require 'package) ;; 初始化包管理器

(unless (bound-and-true-p package--initialized)
  (package-initialize)) ;; 刷新软件源索引

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
   (package-refresh-contents)
   (package-install 'use-package))

;; use-package default config
(eval-and-compile
    (setq use-package-always-ensure t) ;不用每个包都手动添加:ensure t关键字
    (setq use-package-always-defer t) ;默认都是延迟加载，不用每个包都手动添加:defer t
    (setq use-package-always-demand nil)
    (setq use-package-expand-minimally t)
    (setq use-package-verbose t))

(use-package yaml-mode)
(use-package restart-emacs)
(use-package gruvbox-theme
    ; :init (load-theme 'gruvbox-dark-soft t))
    :init (load-theme 'gruvbox-dark-hard t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
