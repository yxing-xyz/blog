---
title: "Elisp"
date: 2021-08-18T21:56:00+08:00
lastmod: 2021-08-18T21:56:00+08:00
draft: false
categories:
  - "编程"
tags:
  - "编程"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
<!--more-->
## 定义变量
1. 全局变量
```lisp
(setq a1 3)
(defvar a1 3 "temp varlue") ;; 多了一个变量描述字符串  C-h v能看到描述
```
2. 局部变量
let中变量列表的赋值顺序是不定的，因此在第一个例子里 a3 无法使用 a2 的值；而 let* 中后面变量的声明可以使用前面变量的值。
```lisp
(let ((a2 3)
      a3)
  (setq a3 1)
  (message "%s %s" a2 a3))

(let* ((a2 3)
       (a3 a2))
  (message "%s %s" a2 a3))
```


## 基本类型
```lisp
3 ;; int
3.5 ;; float
"string" ;; string
t ;; bool
nil ;; 空 只有nil == (), 空表 nil是false
```
## 复合类型
基础的集合结构都由序对进行组成。
**'**这个符号被称为引用符（quote）。它的作用是表示后面的表不立即求值，而把其当作一个字面值处理.

```lisp
;; 空表 false
'() == (quote ()) == nil

;; 类似js的eval然后调用函数
(setq testquote '(+ 1 2))
(apply testquote) ;; 3

;; cons 用于构建序对，car 用于取前面的元素，cdr 用于取后面的元素 (序对与 list 的区别就是 list 的最后一个元素为 nil)
(setq three (cons 1 (cons 2 (cons 3 nil))))
;; 等价于
(setq three (list 1 2 3))


;; alist可以做map使用 lua php的关联数组和这个很像
(setq color-alist '((red . "ff0000")
                    (green . "00ff00")
                    (blue . "0000ff")))
(car green-item) ;; green
(cdr green-item) ;; "00ff00"
(add-to-list 'color-alist '(green . "00ff01")) -> ((green . "00ff01") (red . "ff0000") (green . "00ff00") (blue . "0000ff"))
(cdr (assoc 'green color-alist));; "00ff01"
```

## 控制结构
```lisp
;; 顺序
;; (progn expr1 expr2 ...)

;; 条件
(let ((a2 3))
  (if (> a2 1)
      (progn
        (setq a2 2)
        (message "Right %s" a2))
    (message "Wrong %s" a2)))

;; when 没有else分支的if
(let ((a2 3))
    (when (> a2 1)
    (message "hello")))

;; unless 没有then分支的if
(let ((a2 3))
    (unless (< a2 1)
    (message "hello")))

;; cond 多条件语句 多条件语句，返回值为最后执行的语句。

;; (cond ((test1 body11 body12 ...)
;;       (test2 body21 body22 ...)
;;       ...
;;       (t bodyn1 bodyn2 ...)))
(let ((a4 4))
  (cond ((> a4 3) (message "1") (message ">"))
        ((= a4 3) (message "1") (message "="))
        ((< a4 3) (message "1") (message "<"))))
```

## 逻辑语句
```lisp
;; and 会顺序执行表达式，直到遇到 nil。所以返回值为 nil 或者最后一个语句。通常，
;; (if expr1
;;     (if expr2
;;        ..
;;    (if exprn-1 exprn)))
;; 简写作
;; (and expr1 exp2 ...)


;; or 会顺序执行表达式，直到遇到一个非 nil。所以返回值为第一个非 nil 的值。
;; (if a a b)
;; 简写作
;; (or a b)

;; not 为非：
;; (not expr)
```

## 循环语句
```lisp
;; while 返回值为 nil。
;; (while test
;;   body1 body2 ...)
(let ((count 3))
  (while (> count 0)
    (message "%d" count)
    (setq count (1- count))))

;; elisp 提供了更方便的对 list 的遍历方法，返回值为 nil。
(let ((templist '(1 2 3)))
  (dolist (var templist)
    (message "%d" var)))
```

## 函数
```lisp
(setq func1 (lambda () (message "hello")))
(funcall func1)

(defun func1 ()
  (message "hello"))
(func1) ;; -> "hello"

;; 一个常见的 defun 是这样的。第一个元素为函数名，后面的列表是参数列表，参数可以使用&rest 和&optional 修饰；下面有一个可选的文档字符串以及一个可选的声明列表，最常见的就是 (interactive)，表示这个函数是一个可交互的函数，即用户可以通过关联快捷键或者 M-x 的方式直接调用该函数。对于不需要名字的函数，可以使用 lambda 表达式：
(bind-key (kbd "C-c C-1") (lambda () (interactive) (message "hello")) global-map)

;; &rest: 多个参数 可变参数 类似golang ...
;; &optional:可选参数，可填或忽略，默认nil
```

## 修饰
类似java的动态代理
```lisp
(defun example-func (p1 p2 p3)
  (message "%d %d %d" p1 p2 p3))

(defun example-advice (oldfunc &rest args)
  (setcar (nthcdr 1 args) 0)
  (apply oldfunc args))

(example-func 1 2 3)
;; -> "1 2 3"

(advice-add 'example-func :around 'example-advice)
(example-func 1 2 3)
;; -> "1 0 3"
```

## 宏
