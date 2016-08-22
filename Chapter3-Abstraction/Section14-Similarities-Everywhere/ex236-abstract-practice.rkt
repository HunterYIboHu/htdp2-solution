;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex236-abstract-practice) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Create test cases for the following two functions
; Lon -> Lon
; add 1 to each item on l

(check-expect (add1* '(1 3 5 7)) '(2 4 6 8))
(check-expect (add1* '(1 3 4 9)) '(2 4 5 10))

(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (add1 (first l))
       (add1* (rest l)))]))



; Lon -> Lon
; adds 5 to each item on l

(check-expect (plus5 '(1 3 5 7)) '(6 8 10 12))
(check-expect (plus5 '(1 3 4 9)) '(6 8 9 14))

(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ (first l) 5)
       (plus5 (rest l)))]))


;; abstract the above two functions
; Number Lon -> Lon
; add the given n to each item on l

(check-expect (add* 1 '(1 3 5 7)) '(2 4 6 8))
(check-expect (add* 13 '(24 25 26)) '(37 38 39))

(define (add* n l)
  (cond [(empty? l) '()]
        [else (cons (+ (first l) n)
                    (add* n (rest l)))]))


;; define the front two functions with add*
; Lon -> Lon
; add 1 to each item on l

(check-expect (add1*.v2 '(1 3 5 7)) '(2 4 6 8))
(check-expect (add1*.v2 '(1 3 4 9)) '(2 4 5 10))

(define (add1*.v2 l)
  (add* 1 l))


; Lon -> Lon
; adds 5 to each item on l

(check-expect (plus5.v2 '(1 3 5 7)) '(6 8 10 12))
(check-expect (plus5.v2 '(1 3 4 9)) '(6 8 9 14))

(define (plus5.v2 l)
  (add* 5 l))


;; design a new function with add*
; Lon -> Lon
; sub 2 to each item on l

(check-expect (sub2 '(1 3 5 7)) '(-1 1 3 5))
(check-expect (sub2 '(-10 100 20.2 0)) '(-12 98 18.2 -2))

(define (sub2 l)
  (add* -2 l))

