;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex255-simple-formulate-signature2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Exercise 255. Formulate signatures for the following functions: 
;;map-n, which consumes a list of numbers and a function
;;from numbers to numbers to produce a list of numbers.
;;map-s, which consumes a list of strings and a function
;;from strings to strings and produces a list of strings.
;;Then abstract over the two signatures, following the above steps.
;;Also show that the generalized signature can be instantiated to describe
;;the signature of the map-IR function above.


;; following signatures
; [List-of Number] [Number -> Number] -> [List-of Number]
(define (map-n lon F) '(0))


; [List-of String] [String -> String] -> [List-of String]
(define (map-s los F) '("Hello world"))


;; abstracted signature
; [X] [List-of X] [X -> X] -> [List-of X]


; [List-of IR] [IR -> IR] -> [List-of IR]
(define (map-IR loir F) "")