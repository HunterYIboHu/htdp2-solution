;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex345-represent-add-mul) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct add [left right])
; An Add is a structure:
;    (make-add BSL-expr BSL-expr)

(define-struct mul [left right])
; An Mul is a structure:
;    (make-mul BSL-expr BSL-expr)

; BSL-expr is one of:
; - Number
; - Add
; - Mul


;; constants
(define expr-1 (make-add 10 -10))
(define expr-2 (make-add (make-mul 20 3) 33))
(define expr-3 (make-add (make-mul 3.14 (make-mul 2 3))
                         (make-mul 3.14 (make-mul -1 -9))))
(define expr-4 (make-add -1 2)) ; (+ -1 2)
(define expr-5 (make-add (make-mul -2 -3) 33)) ; (+ (* -2 -3) 33)
(define expr-6 (make-mul (make-add 1 (make-mul 2 3)) 3.14)) ; (* (+ 1 (* 2 3)) 3.14)