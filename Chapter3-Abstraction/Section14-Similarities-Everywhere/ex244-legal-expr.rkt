;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex244-legal-expr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; function definitions
(define (f-1 x) (x 10))
(define (f-2 x) (x f-2))
(define (f-3 x y) (x 'a y 'b))


;; Questions
;;;; why the above sentences are now legal?
;;;; A: Because now function can be a value as parameter. they only need
;;;; consume not others but a function.