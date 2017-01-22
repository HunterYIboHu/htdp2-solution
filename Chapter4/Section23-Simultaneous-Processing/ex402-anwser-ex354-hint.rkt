;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex402-anwser-ex354-hint) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise402. Re-read exercise 354.
;Explain the reasoning behind our hint to
;think of the given expression as an atomic value at first.

;; Exercise 354's Hint:
;;Think of the given BSL-var-expr as an atomic value and
;;traverse the given association list instead. We provide this hint because
;;the creation of this function requires a little design knowledge
;;from Simultaneous Processing.

;; Answers:
;; Because BSl-var-expr and AL are both lists, and the function need to processing
;; them simultaneously.