;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.6-ufo) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct vel [deltax deltay])
; A Vel is a structure:  (make-vel Number Number)
; interpretation
; (make-vel dx dy) means a velocity of dx pixels [per tick]
; along the horizontal and dy pixels along the vertical direction


(define-struct ufo [loc vel])
; A UFO is a structure:  (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location p moving at
; velocity v. For Vel, see above.


(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))


; Posn Vel -> Posn
; adds v to p
; examples:
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))

(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))


; UFO -> UFO
; determines where u moves in one clock tick;
; leaves the velocity as is

(check-expect (ufo-move-1 u1) u3)
; change the position, not the velocity
(check-expect (ufo-move-1 u2) (make-ufo (make-posn 17 77) v2))
; change the position, not the velocity. But write the result of
; posn

(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))




