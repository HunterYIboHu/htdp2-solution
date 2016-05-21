;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname UFO-fly) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define HEIGHT 100)
(define WIDTH 100)
(define MIDWIDTH (/ WIDTH 2))
(define MTSCN (empty-scene HEIGHT WIDTH))
(define UFO
  (overlay (circle 10 "solid" "green")
           (rectangle 40 4 "solid" "green")))
(define UFO-CENTER-TO-BOTTOM
  (- HEIGHT (/ (image-height UFO) 2)))

; 函数
(define (create-ufo-scene h)
  (cond
    [(<= h UFO-CENTER-TO-BOTTOM)
     (place-image UFO MIDWIDTH h MTSCN)]
    [(> h UFO-CENTER-TO-BOTTOM)
     (place-image UFO MIDWIDTH
                  UFO-CENTER-TO-BOTTOM MTSCN)]))

; 运行
(animate create-ufo-scene)