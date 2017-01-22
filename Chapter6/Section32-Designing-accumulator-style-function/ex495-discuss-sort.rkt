;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex495-discuss-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)
; interpretation a brunch of numbers


;; main functions
; List-of-numbers -> List-of-numbers
; rearrangle alon in descending order

(check-expect (sort> '()) '())
(check-expect (sort> (list 12 20 -5)) (list 20 12 -5))
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))

(define (sort> alon)
  (cond [(empty? alon) '()]
        [else (insert (first alon) (sort> (rest alon)))]))


;; auxiliary functions
; Number List-of-numbers -> List-of-numbers
; insert n into the sorted list of numbers alon

(check-expect (insert 5 '()) (list 5))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5)) (list 20 12 -5))
(check-expect (insert -10 (list 20 -5)) (list 20 -5 -10))
(check-expect (insert 30 (list 20 -5)) (list 30 20 -5))

(define (insert n alon)
  (cond [(empty? alon) (cons n '())]
        [else (if (>= n (first alon))
                  (cons n alon)
                  (cons (first alon) (insert n (rest alon))))]))


;; Questions
;; Q1: Does the insertion sort> function from Auxiliary Functions that
;; Recur need an accumulator? If so, why? If not, why not? 
;; A1: Do not need, because the insert do not need to know the
;; acknowledge of the given list, because it's cons is unregular ... 










