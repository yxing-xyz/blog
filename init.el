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
