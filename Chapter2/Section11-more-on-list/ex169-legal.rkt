;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex169-legal) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Design the function legal. Like translate from exercise 168
; the function consumes and produces a list of Posns.
; The result contains all those Posns
; whose x-coordinates are between 0 and 100
; and whose y-coordinates are between 0 and 200.


;; data difinitions
; NELop (non-empty list of posns) is one of:
; - (cons Posn '())
; - (cons Posn Lop)
; interpretation an instance of Lop represents a number of
; Posns.

(define ONE-LEGAL (cons (make-posn 101 200)
                        (cons (make-posn 100 50)
                              (cons (make-posn 20 -20)
                                    '()))))
(define ALL-LEGAL (cons (make-posn 50 50)
                        (cons (make-posn 20 40)
                              (cons (make-posn 30 69)
                                    '()))))
(define ILLEGAL (cons (make-posn 10000 200)
                      (cons (make-posn 10 100000)
                            (cons (make-posn 2000 2000)
                                  '()))))


;; constants
(define X-MAX 100)
(define X-MIN 0)
(define Y-MAX 200)
(define Y-MIN 0)


;; main functions
; NELop -> NELop
; consume an-lop and produce an NELop which contains posn
; that x-coordinate is between 0 and 100, and y-coordinate
; is between 0 and 200.

(check-expect (legal ONE-LEGAL) (cons (make-posn 100 50) '()))
(check-expect (legal ALL-LEGAL) ALL-LEGAL)
(check-expect (legal ILLEGAL) '())

(define (legal an-lop)
  (cond [(empty? an-lop) '()]
        [(cons? an-lop)
         (if (auxi/legal (first an-lop))
             (cons (first an-lop) (legal (rest an-lop)))
             (legal (rest an-lop)))]))


;; auxilliary functions
; Posn -> Boolean
; consume a posn, if the coordinata is legal, then return #true;
; else return false.

(check-expect (auxi/legal (make-posn 10 10)) #t)
(check-expect (auxi/legal (make-posn -10 10)) #f)
(check-expect (auxi/legal (make-posn 0 200)) #t)
(check-expect (auxi/legal (make-posn 100 200)) #t)

(define (auxi/legal p)
  (and (<= X-MIN (posn-x p) X-MAX)
       (<= Y-MIN (posn-y p) Y-MAX)))

