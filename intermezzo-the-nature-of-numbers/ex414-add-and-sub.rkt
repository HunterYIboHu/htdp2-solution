;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex415-add-and-sub) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N -> Number
; adds up n copies of #i1/185, and then produces the result.

(check-range (add 185) 0.99 1.0)
(check-range (add 370) 1.99 2.0)
(check-range (add 555) 2.99 3.0)
(check-range (add 1) 1/185 2/185)

(define (add n)
  (cond [(>= 0 (- n 0.0001)) 0]
        [else (+ #i1/185 (add (sub1 n)))]))


; Number -> N
; counts how often 1/185 can be subtracted from the argument
; until it's 0.

(check-range (sub 1) 185 186)
(check-range (sub 1/185) 0 1)
(check-range (sub 51/185) 51 52)
(check-range (sub 0) 0 1)

(define (sub num)
  (cond [(<= num 0) 0]
        [else (+ 1 (sub (- num #i1/185)))]))


;; Questions
;; Q1: What is the result for (add 185)?
;; A1: It's #i0.9999999999999949.
;;
;; Q2: What would you expect?
;; A2: 1.
;;
;; Q3: What happens if you multiply the result with a large number
;; A3: The mantissa of the result will more inexactly.
;;
;; Q4: What are the expected results?
;; A4: (sub 0) is 0, (sub 1/185) is 1.
;;
;; Q5: What are the results for (sub 1) and (sub #i1.0)?  
;; A5: the result of (sub 1) and (sub #i1.0) is the same.

