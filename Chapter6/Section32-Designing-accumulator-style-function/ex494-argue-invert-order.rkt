;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex494-argue-invert-order) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Questions
;; Q1: Argue that, in the terminology of Intermezzo: The Cost of
;; Computation, invert consumes O(n2) time when the given list
;; consists of n items.
;; A1: Because invert will call invert and add-as-last n times,
;; and the run recursive call time of add-as-last is \sum{l=n-1}{l=0}.
;; so the result is (+ n (/ (* n (- n 1)) 2)).