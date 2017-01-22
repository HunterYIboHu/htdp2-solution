;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex479-threatening) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data definitions
(define QUEENS 8)
; A QP is a structure:
;    (make-posn CI CI)
; A CI is an N in [0, QUEENS).
; interpretation (make-posn r c) denotes the square at
; the r-th row and c-th column.


;; data examples
(define QP-1 (make-posn 1 2))
(define QP-2 (make-posn 1 5))
(define QP-3 (make-posn 5 2))
(define QP-4 (make-posn 2 3))
(define QP-5 (make-posn 2 1))


;; functions
; QP QP -> Boolean
; determine whether former will threaten the latter.
; threaten means :
; (1) the same x-coordinate
; (2) the same y-coordinate
; (3) the former's x-coordinate + the latter's y-coordinate equals
; the latter's x-coordinate + the former's y-coordinate.
; (4) the former's x plus y equals the latter's x plus y

(check-expect (threatening? QP-1 QP-2) #t)
(check-expect (threatening? QP-1 QP-3) #t)
(check-expect (threatening? QP-1 QP-4) #t)
(check-expect (threatening? QP-1 QP-5) #t)
(check-expect (threatening? QP-2 QP-3) #f)
(check-expect (threatening? QP-3 QP-4) #f)

(define (threatening? former latter)
  (local ((define f-x (posn-x former))
          (define f-y (posn-y former))
          (define l-x (posn-x latter))
          (define l-y (posn-y latter)))
    (cond [(or (= f-x l-x)
               (= f-y l-y)
               (= (+ f-x l-y) (+ f-y l-x))
               (= (+ f-x f-y) (+ l-x l-y)))
           #true]
          [else #false])))

