;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex356-BSL-func-expr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

(define-struct add [left right])
; An Add is a structure:
;    (make-add BSL-func-expr BSL-func-expr)

(define-struct mul [left right])
; An Mul is a structure:
;    (make-mul BSL-func-expr BSL-func-expr)

(define-struct func [name args body])
; An Func is a structure:
;    (make-func Symbol [List-of Symbol] BSL-func-expr)

; BSL-expr is one of:
; - Number
; - Add
; - Mul

; BSL-var-expr is one of:
; - Number
; - Symbol
; - Add
; - Mul

; BSL-func-expr is one of:
; - Number
; - Symbol
; - Add
; - Mul
; - Func


;; constants
(define k (make-func 'k '(a) (- a 1)))
(define i (make-func 'i '(a) (+ a 1)))

(define expr-1 ('k (make-add 1 1)))
(define expr-2 (make-mul 5 ('k (make-add 1 1))))
(define expr-3 (make-mul ('i 5)
                         ('k (make-add 1 1))))

