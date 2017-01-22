;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex254-simple-formulate-signature) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;; Questions ;;;;
;;Exercise 254. Formulate signatures for the following functions: 
;;sort-n, which consumes a list of numbers and a function that
;;consumes two numbers (from the list) and produces a Boolean;
;;sort-n produces a sorted list of numbers.
;;sort-s, which consumes a list of strings and a function that
;;consumes two strings (from the list) and produces a Boolean;
;;sort-s produces a sorted list of strings.
;;Then abstract over the two signatures, following the above steps.
;;Also show that the generalized signature can be instantiated to
;;describe the signature of a sort function for lists of IRs.

;; following signatures
; [List-of Number] [Number Number -> Boolean] -> [List-of Number]
(define (sort-n lon F) #false)


; [List-of String] [String String -> Boolean] -> [List-of String]
(define (sort-s los F) "String")


;; abstract signature
; [X] [List-of X] [X X -> Boolean] -> [List-of X]


;; examples:
; [List-of IR] [IR IR -> Boolean] -> [List-of IR]