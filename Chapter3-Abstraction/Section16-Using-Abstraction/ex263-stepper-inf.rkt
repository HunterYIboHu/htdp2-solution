;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex263-stepper-inf) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define list-1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13
                     12 11 10 9 8 7 6 5 4 3 2 1))
 
(define list-2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
                     17 18 19 20 21 22 23 24 25))


;; functions
; Nelon -> Number
; determines the smallest number on l

;(check-expect (inf.v2 list-1) 1)
;(check-expect (inf.v2 list-2) 1)
;(check-expect (inf.v2 '( 14 54 23 54 22 3 96 3 122 345 2 5 3 0 1 3 4)) 0)

(define (inf.v2 l)
  (cond [(empty? (rest l)) (first l)]
        [else (local ((define smallest-in-rest (inf.v2 (rest l))))
                (if (< (first l) smallest-in-rest)
                    (first l)
                    smallest-in-rest))]))


;; use stepper
(inf.v2 '(1 2 0 4))