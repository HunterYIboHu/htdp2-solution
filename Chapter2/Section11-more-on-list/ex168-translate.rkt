;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex168-translate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Design the function translate. It consumes and produces lists of Posns.
; For each (make-posn x y) in the former,
; the latter contains (make-posn x (+ y 1)).
; We borrow the word “translate” from geometry, where
; the movement of a point by a constant distance
; along a straight line is called a translation.


;; data difinitions
; NELop (non-empty list of posns) is one of:
; - (cons Posn '())
; - (cons Posn Lop)
; interpretation an instance of Lop represents a number of
; Posns.

(define ONE (cons (make-posn 10 20) '()))
(define TWO (cons (make-posn 10 20) (cons (make-posn 35 42) '())))


;; constants
(define Y-MOVEMENT 1)


;; main function
; NELop -> NELop
; add1 to every posn's y-coordinate in an-lop

(check-expect (translate ONE) (cons (make-posn 10 21) '()))
(check-expect (translate TWO) (cons (make-posn 10 21)
                                    (cons (make-posn 35 43)
                                          '())))

(define (translate an-lop)
  (cond [(empty? an-lop) '()]
        [(cons? an-lop)
         (cons (auxi/trans (first an-lop)) (translate (rest an-lop)))]))


;; auxilliary functions
; Posn -> Posn
; add1 to the given posn's y-coordinate

(check-expect (auxi/trans (make-posn 10 20)) (make-posn 10 21))
(check-expect (auxi/trans (make-posn 35 42)) (make-posn 35 43))

(define (auxi/trans p)
  (make-posn (posn-x p) (+ Y-MOVEMENT (posn-y p))))







