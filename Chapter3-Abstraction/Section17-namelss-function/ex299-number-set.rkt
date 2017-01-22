;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex299-number-set) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An NumberSet is a function:
;    [Number -> Boolean]
; interpretation is ns is a NumberSet and n is a Number,
; (ns n) produces #true if n is in of ns, #false otherwise.


; [List-of Number] -> NumberSet
; generates a finite set with elements from the given l

(check-expect (belong-to (mk-finite '(1 2 3 4 5)) 5) #true)
(check-expect (belong-to (mk-finite '(1 2 3 4 5)) 6) #false)

(define (mk-finite l)
  (lambda (num)
    (member? num l)))


; Number -> Boolean
; represent a set consist of all even number.

(check-expect (belong-to even-number 2) #true)
(check-expect (belong-to even-number 3) #false)
(check-expect (belong-to even-number 0) #true)
(check-expect (belong-to even-number 0+i) #false)

(define even-number
  (lambda (num)
    (and (integer? num) (even? num))))


; Number -> Boolean
; represent a set consist of all odd number.

(check-expect (belong-to odd-number 2) #false)
(check-expect (belong-to odd-number 1) #true)
(check-expect (belong-to odd-number 0) #false)
(check-expect (belong-to odd-number 0+i) #false)

(define odd-number
  (lambda (num)
    (and (integer? num) (odd? num))))


; Number -> Boolean
; represent a set consist of all number divisible by 10.

(check-expect (belong-to divisible-10 2) #false)
(check-expect (belong-to divisible-10 10) #true)
(check-expect (belong-to divisible-10 3560) #true)
(check-expect (belong-to divisible-10 0+i) #false)

(define divisible-10
  (lambda (num)
    (and (integer? num) (zero? (remainder num 10)))))


; NumberSet Number -> NumberSet
; adds an element to the given ns.

(check-expect [(add-element odd-number 2) 2] #true)
(check-expect [(add-element odd-number 2) 4] #false)
(check-expect [(add-element odd-number 2+3i) 2+3i] #true)

(define (add-element ns element)
  (lambda (num)
    (or (ns num)
        (= element num))))


; NumberSet NumberSet -> NumberSet
; combines the elements of two set.

(check-expect [(union odd-number even-number) 2] #true)
(check-expect [(union odd-number even-number) 3] #true)
(check-expect [(union odd-number divisible-10) 10] #true)

(define (union ns-1 ns-2)
  (lambda (num)
    (or (ns-1 num) (ns-2 num))))


; NumberSet NumberSet -> NumberSet
; collects all elements common to 2 sets.

(check-expect [(intersect odd-number even-number) 2] #false)
(check-expect [(intersect odd-number even-number) 3] #false)
(check-expect [(intersect even-number divisible-10) 10] #true)

(define (intersect ns-1 ns-2)
  (lambda (num)
    (and (ns-1 num) (ns-2 num))))


; NumberSet Number -> Boolean
; determine whether the given num is in of ns.
(define (belong-to ns num)
  (ns num))

