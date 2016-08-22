;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex139-sum-function) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-amounts is one of:
; - '()
; - (cons PositiveNumber List-of-amounts)
; interpretation a List-of-amounts represents some amounts of money
; examples:

(define origin '())
(define sec (cons 1 '()))
(define thd (cons 2 (cons 1 '())))


; List-of-amouts -> Number
; determine the sum of Numbers on l, is l is empty, the result is 0.
; examples:

(check-expect (sum origin) 0)
(check-expect (sum sec) 1)
(check-expect (sum thd) 3)
(check-error (sum 20))

(define (sum l)
  (cond [(empty? l) 0]
        [(cons? l)
         (+ (first l) (sum (rest l)))]
        [else (error "TypeError: l should be a list.")]))