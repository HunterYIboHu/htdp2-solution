;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex251-fold1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; main functions
; [List-of Number] Number [Number -> Number] -> [List-of Number]
; a universal functions to apply given functions on the numbers of the list.
; if the given list is empty, return the default value.

(check-expect (fold1 '(1 2 3) 0 +) (sum '(1 2 3)))
(check-expect (fold1 '(1 2 3) 1 *) (product '(1 2 3)))

(define (fold1 l default F)
  (cond [(empty? l) default]
        [else (F (car l) (fold1 (cdr l) default F))]))


;; auxiliary functions
; [List-of Number] -> Number
; computes the sum of the numbers on l

(check-expect (sum `(1 2 3)) 6)
(check-expect (sum `(-1 0 1)) 0)
(check-expect (sum '()) 0)

(define (sum l)
  (cond [(empty? l) 0]
        [else (+ (car l) (sum (cdr l)))]))


; [List-of Number] -> Number
; computes the product of the numbers on l

(check-expect (product '(1 2 3)) 6)
(check-expect (product '(10 5 2)) 100)
(check-expect (product '()) 1)

(define (product l)
  (cond [(empty? l) 1]
        [else (* (car l) (product (cdr l)))]))