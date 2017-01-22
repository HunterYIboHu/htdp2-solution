;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex256-argmin) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define DELTA 0.0001)


;; functions
; Posn -> Number
; compute the distance of given p from origin.

(check-within (from-origin (make-posn 3 4)) 5 DELTA)
(check-within (from-origin (make-posn 6 8)) 10 DELTA)

(define (from-origin p)
  (sqrt (+ (sqr (posn-x p))
           (sqr (posn-y p)))))


;; concrete examples in ISL of argmax
(argmax from-origin `(,(make-posn 3 4) ,(make-posn 6 8) ,(make-posn 5 12)))


;; argmin's purpose statement
; [X] [X -> Number] [NEList-of X] -> X
; finds the (first) item in lx that minimizes f
; if (argmin f (list x-1 ... x-n)) == x-i,
; then (>= (f x-i) (f x-1)), (>= (f x-i) (f x-2)), ...
;; (define (argmin f lx) ...)


