;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex148-nelob) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A NEList-of-booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-booleans)
; interpretation non-empty list of Boolean values.
; examples:
(define ONE-TRUE (cons #t (cons #f (cons #f '()))))
(define TWO-TRUE (cons #t (cons #f (cons #t '()))))
(define ALL-TRUE (cons #t (cons #t (cons #t '()))))
(define ALL-FALSE (cons #f (cons #f (cons #f '()))))


; NEList-of-booleans -> Boolean
; determine weather all the booleans on l is #true.
; examples:

(check-expect (all-true ONE-TRUE) #false)
(check-expect (all-true TWO-TRUE) #false)
(check-expect (all-true ALL-TRUE) #true)

(define (all-true l)
  (cond [(empty? (rest l)) #true]
        [(cons? (rest l)) (and (first l)
                               (all-true (rest l)))]))


; NEList-of-booleans -> Boolean
; determine weather at least one item on the l is #true.
; examples:

(check-expect (one-true ONE-TRUE) #true)
(check-expect (one-true ALL-TRUE) #true)
(check-expect (one-true ALL-FALSE) #false)

(define (one-true l)
  (cond [(empty? (rest l)) #false]
        [(cons? (rest l)) (or (first l)
                              (one-true (rest l)))]))






