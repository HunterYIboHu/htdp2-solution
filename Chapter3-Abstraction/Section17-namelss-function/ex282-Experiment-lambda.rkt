;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex282-Experiment-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> Number
; produces the 10 times of the given num.

(define (f-plain x)
  (* 10 x))


; Number -> Number
; produces the 10 times of the given num.

(define f-lambda
  (lambda (x) (* 10 x)))


; Number -> Boolean
(define (compare x)
  (= (f-plain x) (f-lambda x)))