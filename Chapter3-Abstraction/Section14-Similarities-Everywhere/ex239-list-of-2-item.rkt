;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex239-list-of-2-item) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List of two items


;; data difinitions
; A [List X Y] is a structure:
;    (cons X (cons Y '()))


; pair of Numbers is
;    [List Number Number]

(define pon-1 (list 1 2))
(define pon-2 (list 2 4))


; pair of Numbers and 1Strings is
;    [List Number 1String]

(define pons-1 (list 1 "a"))
(define pons-2 (list 10 "z"))


; pair of Strings and Booleans is
;    [List String Boolean]

(define posb-1 (list "a" #false))
(define posb-2 (list "zoo" #true))