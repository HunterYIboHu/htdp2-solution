;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex500-product) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; [List-of Number] -> [Maybe Number]
; produces the product of the numbers on lon0.
; if lon is empty, then return #false.

(check-expect (product '(1 2 3)) 6)
(check-expect (product '(10 20 4.5)) 900)
(check-expect (product '()) #f)

(define (product lon0)
  (local (; [List-of Number] Number -> Number
          ; produces the product of lon0.
          ; accumulator r is the numebr represent the product
          ; from the (first lon0) to the (first lon).
          (define (product/a lon r)
            (cond [(empty? lon) r]
                  [else (product/a (rest lon)
                                   (* (first lon) r))]))
          )
    (if (empty? lon0)
        #false
        (product/a lon0 1))))


;; Questions
;; Q1: Does the accumulator version improve on this?
;; A1: The performance is still O(n).