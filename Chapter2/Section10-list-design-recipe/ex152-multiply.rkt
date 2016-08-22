;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex153-multiply) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A N is one of:
; - 0
; - (add1 N)
; interpretation represents the natural numbers or counting numbers


; N Number -> Number
; computes (* n x) without using *

(check-expect (multiply 3 4) (* 3 4))
(check-expect (multiply 10 2) (* 10 2))
(check-expect (multiply 0 200) 0)

(define (multiply n x)
  (cond [(zero? n) 0]
        [(positive? n) (+ x (multiply (sub1 n) x))]))














