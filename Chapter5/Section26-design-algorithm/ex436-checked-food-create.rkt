;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex436-checked-food-create) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define MAX 100)

; functions
; Posn -> Posn
; produces a random position which is not same as the origin.
; termination when MAX is 1, origin is not (make-posn 0 0).

(check-satisfied (food-create (make-posn 10 20))
                 (not-equal-posn (make-posn 10 20)))
(local ((define pos (make-posn 20 10)))
  (check-satisfied (food-create pos)
                   (not-equal-posn pos)))
;(check-error (food-create (make-posn 0 0)))

(define (food-create origin)
  (local ((define terminate (= 1 MAX))
          (define new
            (make-posn (random MAX) (random MAX))))
    (cond [(and terminate
                (equal? origin (make-posn 0 0)))
           (error "The function would loop.")]
          [(equal? origin new) (food-create origin)]
          [else new])))


;; check functions
; Posn -> [Posn -> Boolean]
; produces a function which determine new is not equal to origin.

(define (not-equal-posn origin)
  (lambda (new) (not (equal? origin new))))