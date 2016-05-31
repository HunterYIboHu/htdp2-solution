;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex69-ballf) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; struct constant
(define-struct ballf [x y deltax deltay])
(define-struct ball [location direction])
(define-struct vel [deltax deltay])

; physics constants
(define ball1 (make-ballf 30 40 -10 5))
; 问题在于其语义化程度低，虽然存储的内容与ball相同，但是不能直观地通过
; 实例的创建来理解每个参数的意义和作用

(define ball2 (make-ball (make-posn 30 40) (make-vel -10 5)))
; 良好的语义，使得阅读者迅速理解：前两个参数是位置坐标，后两个参数
; 是向量坐标