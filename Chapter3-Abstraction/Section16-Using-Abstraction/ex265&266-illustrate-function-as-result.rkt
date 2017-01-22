;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex265&266-illustrate-function-as-result) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
((local ((define (f x) (+ (* 4 (sqr x)) 3))) f) 1)
((local ((define (f x) (+ x 3))
         (define (g x) (* x 4)))
   (if (odd? (f (g 1)))
       f
       g))
 2)