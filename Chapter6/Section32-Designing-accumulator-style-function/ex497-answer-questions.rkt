;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex497-answer-questions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; N -> N 
; compute (* n (- n 1) (- n 2) ... 1)

(check-expect (!.v1 3) 6)

(define (!.v1 n)
  (cond
    [(zero? n) 1]
    [else (* n (!.v1 (sub1 n)))]))


; N -> N 
; compute (* n (- n 1) (- n 2) ... 1)

(check-expect (!.v2 3) 6)
(check-expect (!.v2 8) 40320)

(define (!.v2 n0)
  (local (; N ??? -> N
          ; compute (* n (- n 1) (- n 2) ... 1)
          ; accumulator a is the product of the
          ; natural numbers in the interval [n0, n)
          (define (!/a n a)
            (cond
              [(zero? n) a]
              [else (!/a (sub1 n)
                         (* n a))])))
    (!/a n0 1)))


;; Questions
;; Q1: What should the value of a be when n0 is 3 and n is 1?
;; A1: 6.
;; 
;; Q2: How about when n0 is 10 and n is 8?
;; A2: 40320, namely, 8!.