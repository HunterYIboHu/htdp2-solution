;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex458-integrate-kepler) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; Questions
;; Q1: Which of the three tests fails and by how much?
;; A1: 3rd one. Because the given function's shape has an curve, by 125;
;; the computed value is 1125.

