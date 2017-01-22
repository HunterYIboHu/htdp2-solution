;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex253-abstract-signatures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Exercise 253. Each of these signatures describes a class of functions: 
;; [Number -> Boolean]
;; [Boolean String -> Boolean]
;; [Number Number Number -> Number]
;; [Number -> [List-of Number]]
;; [[List-of Number] -> Boolean]
;;Describe these collections with at least one example from ISL. 


;; function signatures


; [Number -> Boolean] ==
;; [X Y] X -> Y

; String -> Boolean


; [Boolean String -> Boolean] ==
;; [X Y] X Y -> Y

; Number String -> String


; [Number Number Number -> Number] ==
;; [X] X X X -> X

; String String String -> String


; [Number -> [List-of Number]] ==
;; [X] X ->  [List-of X]

; String -> [List-of String]


; [[List-of Number] -> Boolean] ==
;; [X Y] [List-of X] -> Y

; [List-of String] -> Boolean

