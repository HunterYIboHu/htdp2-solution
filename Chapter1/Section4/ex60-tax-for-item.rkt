;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.6-tax-for-item) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physics constants
(define INEXPENSIVE 0)
(define EXPENSIVE 5/100)
(define LUXURY 8/100)
(define EXPENSIVE-START 1000)
(define LUXURY-START 10000)


; A Price falls into one of three intervals"
; - 0 through 1000;
; - 1000 through 10000, including 1000;
; - 10000 and above, including 10000;
; interpretation the price of an item


; Price -> Number
; computes the amount of tax charged for price p
; examples:

(check-expect (sales-tax 0) EXPENSIVE)
(check-expect (sales-tax 537) INEXPENSIVE)
(check-expect (sales-tax EXPENSIVE-START)
              (* EXPENSIVE EXPENSIVE-START))
(check-expect (sales-tax 1282) (* EXPENSIVE 1282))
(check-expect (sales-tax LUXURY-START)
              (* LUXURY LUXURY-START))
(check-expect (sales-tax 12017) (* LUXURY 12017))

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p EXPENSIVE-START)) INEXPENSIVE]
    [(and (<= EXPENSIVE-START p) (< p LUXURY-START))
     (* EXPENSIVE p)]
    [(>= p LUXURY-START) (* LUXURY p)]))





















