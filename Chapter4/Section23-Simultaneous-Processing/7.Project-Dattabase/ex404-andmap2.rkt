;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex404-andmap2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; functions
; [X Y] [X Y -> Boolean] [List-of X] [List-of Y] -> Boolean
; determine whether f applied to the items of two equally long list
; lox, loy could produces #true; otherwise produces #false.

(check-expect (andmap2 = '(1 2 3 4 5) '(1.0 2.0 3.0 4.0 5.0)) #true)
(check-expect (andmap2 > '(1 3 5 7 9) '(2 4 6 8 10)) #false)
(check-expect (andmap2 symbol=? '(a b c) '(a c b)) #false)

(define (andmap2 f lox loy)
  (local ((define lob (map (lambda (x y) (f x y)) lox loy)))
    (andmap (lambda (b) (boolean=? #true b)) lob)))