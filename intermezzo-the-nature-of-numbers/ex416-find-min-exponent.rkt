;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex416-find-min-exponent) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N -> N
; produces the smallest integer n such that (expt #i10.0 n)
; is stiaal an inexact number and (expt #i10.0 (sub1 n)) is
; approximated with 0.

(check-expect (min-exponent -400) -323)
(check-expect (min-exponent -1) -323)

(define (min-exponent n)
  (cond [(and (< #i0.0 (expt #i10.0 n))
              (= #i0.0 (expt #i10.0 (sub1 n))))
         n]
        [(< #i0.0 (expt #i10.0 n))
         (min-exponent (sub1 n))]
        [(= #i0.0 (expt #i10.0 (sub1 n)))
         (min-exponent (add1 n))]))

(expt #i10.0 -323)
(expt #i10.0 -324)