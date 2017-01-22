;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex460-integrate-dc) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define ε 0.1)

; Number -> Number
(define (constant x) 20)

; Number -> Number
(define (linear x) (* 2 x))

; Number -> Number
(define (square x) (* 3 (sqr x)))


;; functions
; [Number -> Number] Number Number -> Number
; computes the area of f between a and b, in divide-and-conquer
; strategy.
; assume (< a b) holds.

(check-within (integrate-dc constant 12 22) 200 ε)
(check-within (integrate-dc linear 0 10) 100 ε)
(check-within (integrate-dc square 0 10)
              1000
              ε)

(define (integrate-dc f a b)
  (local ((define mid (/ (+ a b) 2))
          (define WIDTH 0.1))
    (cond [(<= (- b a) WIDTH) (integrate-kepler f a b)]
          [else (+ (integrate-dc f a mid)
                   (integrate-dc f mid b))])))


;; auxiliary functions
; [Number -> Number] Number Number -> Number
; produces the approximate area of the f between a and b.
; assume the (< a b) holds.

(check-within (integrate-kepler constant 12 22) 200 ε)
(check-within (integrate-kepler linear 0 10) 100 ε)
(check-within (integrate-kepler square 0 10)
              1000
              ε)

(define (integrate-kepler f a b)
  (local ((define mid (/ (+ a b) 2))
          ; Number Number -> NUmber
          ; computes the given area's approximate value.
          (define (compute-area left right)
            (* 1/2
               (- right left)
               (+ (f left) (f right)))))
    (+ (compute-area a mid)
       (compute-area mid b))))