;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tree) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define (leaf-part color)
  (isosceles-triangle 60 120 "solid" color))
(define trunk
  (rectangle 20 60 "solid" "brown"))
(define over-leaf-1
  (overlay/xy (leaf-part "green")
              0 15
              (leaf-part "red")))
(define leaf-all
  (overlay/xy over-leaf-1
              0 30
              (leaf-part "blue")))
(define MID
  (image-width leaf-all))

(define tree
  (overlay/offset leaf-all
                  0 35
                  trunk))

; 用于显示作图的结果
tree
