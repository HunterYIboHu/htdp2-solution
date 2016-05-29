;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data-definition-f2c) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Temperature is a Number
; interpretation degrees Celsius
(define (f2c f)
  (* 5/9 (- f 32)))

; Number String Image -> Image
; adds s to img, y pixels from top, 10 pixiels to the left
; given:
; 5 for y,
; "hello" for s, and
; (empty-scene 100 100) for img
; expected:
; (place-image (text "hello" 10 "red") 10 5 (empty-scene 100 100))

(define (add-image y s img)
  (place-image (text s 20 "red") 10 y img))

; Number -> Number
; computes the area of a square whose side is len
; given: 2, expect: 4
; given: 7, expect: 49
(define (area-of-square len)
  (sqr len))






