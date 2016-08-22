;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex151-add-to-pi) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A N is one of:
; - 0
; - (add1 N)
; interpretation represents the natural numbers or counting numbers


; N -> Number
; computes (+ n pi) without using +

(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(check-within (add-to-pi 10) (+ 10 pi) 0.001)
(check-within (add-to-pi 0) pi 0.001)

(define (add-to-pi n)
  (cond [(zero? n) pi]
        [(positive? n) (add1 (add-to-pi (sub1 n)))]))
