;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex273-fold-to-map) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #f)))
; [X Y] [X -> Y] [List-of X] -> [List-of Y]
; construct a new list by applying a function to each item on one
; existing list.

(check-expect (map-mock add1 '(1 2 3)) '(2 3 4))
(check-expect (map-mock sqr '(2 3 4)) '(4 9 16))

(define (map-mock func l)
  (local (; X [List-of X] -> [List-of X]
          ; cons the function applied result of x to the given list.
          (define (apply x l)
            (cons (func x) l)))
    (foldr apply '() l)))