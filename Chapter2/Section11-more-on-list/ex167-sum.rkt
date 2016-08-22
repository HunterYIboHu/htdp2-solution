;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex167-sum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Design the function sum, which consumes a list of Posns and
; produces the sum of all of its x-coordinates.


;; data difinitions
; NELop (non-empty list of posns) is one of:
; - (cons Posn '())
; - (cons Posn Lop)
; interpretation an instance of Lop represents a number of
; Posns.

(define ONE (cons (make-posn 10 20) '()))
(define TWO (cons (make-posn 10 20) (cons (make-posn 35 42) '())))


;; main functions
; NELop -> Number
; comsumes an-lop and produce the sum of all of its x-coordinates;

(check-expect (sum ONE) 10)
(check-expect (sum TWO) 45)

(define (sum an-lop)
  (cond [(empty? an-lop) 0]
        [(cons? an-lop)
         (+ (posn-x (first an-lop))
            (sum (rest an-lop)))]))


