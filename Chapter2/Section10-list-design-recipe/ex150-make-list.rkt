;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex150-make-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


; A N is one of:
; - 0
; - (add1 N)
; interpretation represents the natural numbers or counting numbers


; N String -> List-of-strings
; creates a list of n strings s

(check-expect (copier 2 "hello") (cons "hello" (cons "hello" '())))
(check-expect (copier 0 "hello") '())
; The rest tests are for the exercise 150.
(check-expect (copier 2 #true) (cons #t (cons #t '())))
(check-expect (copier 3 10) (cons 10 (cons 10 (cons 10 '()))))
(check-expect (copier 2 (rectangle 10 20 "outline" "red"))
              (cons (rectangle 10 20 "outline" "red")
                    (cons (rectangle 10 20 "outline" "red") '())))

(define (copier n s)
  (cond [(zero? n) '()]
        [(positive? n) (cons s (copier (sub1 n) s))]))


; N String -> List-of-strings
; creates a list of n strings s

(check-expect (copier.v2 2 "hello") (cons "hello" (cons "hello" '())))
(check-expect (copier.v2 0 "hello") '())

(define (copier.v2 n s)
  (cond [(zero? n) '()]
        [else (cons s (copier.v2 (sub1 n) s))]))


; (copier.v2 0.1 "xyz")
; When apply to float number, it will run endless times,
; for the stop condition could not be satisfied.




