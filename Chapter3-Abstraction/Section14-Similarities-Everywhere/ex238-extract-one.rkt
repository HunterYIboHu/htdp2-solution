;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex238-extract-one) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define list-1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13
                     12 11 10 9 8 7 6 5 4 3 2 1))
(define list-2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
                     17 18 19 20 21 22 23 24 25))


;; original functions waiting for abstracting
; Nelon -> Number
; determines the smallest 
; number on l

(check-expect (inf '(1 2 3)) 1)
(check-expect (inf '(10 -3 24 -5)) -5)

(define (inf l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (< (first l)
            (inf (rest l)))
         (first l)
         (inf (rest l)))]))


; Nelon -> Number
; determines the largest 
; number on l

(check-expect (sup '(10 -3 45 23 4)) 45)
(check-expect (sup '(10 -3 3 20 23 25)) 25)

(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (> (first l)
            (sup (rest l)))
         (first l)
         (sup (rest l)))]))


;; main functions
(check-expect (extract-one < '(1 2 3)) (inf '(1 2 3)))
(check-expect (extract-one > '(10 -3 3 20 23 25)) (sup '(10 -3 3 20 23 25)))

(define (extract-one R l)
  (cond [(empty? (rest l)) (first l)]
        [else (if (R (first l)
                     (extract-one R (rest l)))
                  (first l)
                  (extract-one R (rest l)))]))


;; modify the above two functions
; Nelon -> Number
; determines the smallest 
; number on l

(check-expect (inf '(1 2 3)) 1)
(check-expect (inf '(10 -3 24 -5)) -5)

(define (inf-1 l)
  (extract-one < l))


; Nelon -> Number
; determines the largest 
; number on l

(check-expect (sup '(10 -3 45 23 4)) 45)
(check-expect (sup '(10 -3 3 20 23 25)) 25)

(define (sup-1 l)
  (extract-one > l))


;; run program
(sup list-1)
(sup-1 list-1)
; (inf list-1) ;;;; too slow


;; Why are these functions slow on some of the long lists?
;; A: the function need to expand the expression too large that need a lot
;; of compute power.


;; modify original functions
; Nelon -> Number
; determines the smallest 
; number on l

(check-expect (inf-2 '(1 2 3)) 1)
(check-expect (inf-2 '(10 -3 24 -5)) -5)

(define (inf-2 l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else (min (first l) (inf-2 (rest l)))]))


; Nelon -> Number
; determines the largest 
; number on l

(check-expect (sup-2 '(10 -3 45 23 4)) 45)
(check-expect (sup-2 '(10 -3 3 20 23 25)) 25)

(define (sup-2 l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else (max (first l) (sup-2 (rest l)))]))


;; run program again
(inf-2 list-1)
(inf-2 list-2)
(sup-2 list-1)
(sup-2 list-2)


;; Why are these versions (use max and min) so much faster?
;; A: the definitions of max and min function has improved for the large
;; list, such as local definitions.