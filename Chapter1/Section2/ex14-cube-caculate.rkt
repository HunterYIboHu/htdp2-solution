;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cube-caculate) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write mixed-fraction #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 函数
(define (cube-volume side-len)
  (expt side-len 3))

(define (cube-surface side-len)
  (* (sqr side-len) 6))

; 测试
(format "边长为~a的立方体体积为~s。" 10 (cube-volume 10))
(format "边长为~a的立方体表面积为~s" 10 (cube-surface 10))
