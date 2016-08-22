;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex245-function-equal) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; main functions
; Function Function -> Boolean
; consume two functions which are from numbers to numbers,
; determine whether the two produce the same result for 1.2, 3, and -5.775.

(check-expect (function=at1.2-3-and-5.775? add1 sub1) #false)
(check-expect (function=at1.2-3-and-5.775? add1 add1) #true)
(check-expect (function=at1.2-3-and-5.775? add1 plus1) #true)

(define (function=at1.2-3-and-5.775? func-1 func-2)
  (and (= (func-1 1.2) (func-2 1.2))
       (= (func-1 3) (func-2 3))
       (= (func-1 -5.775) (func-2 -5.775))))


;; auxiliary functions
; Number -> Number
; add 1 to the given number.

(check-expect (plus1 1) 2)
(check-expect (plus1 10) 11)
(check-expect (plus1 0) 1)

(define (plus1 n)
  (+ 1 n))


;; Questions
;;;; Can we hope to define function=?, which determines whether two
;;;; functions from numbers to numbers are equal?
;;;; A: No. Now we could explore the function's body, so it's unable to prove
;;;; the equality by prover; and the infinite inputs makes it impossible to
;;;; test all the output.