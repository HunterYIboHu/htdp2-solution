;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex347-eval-expression) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; An Expression is one of:
; - Number
; - (+ Expression Expression)
; - (* Expression Expression)


;; constants
(define expr-1 (make-add 1 1))
(define expr-2 (make-mul 3 10))
(define expr-3 (make-add (make-mul 1 1) 10))


; functions
; BSL-expr -> Number
; produces the value of the given expr.

(check-expect (eval-expression 3) 3)
(check-expect (eval-expression expr-1) 2)
(check-expect (eval-expression expr-2) 30)
(check-expect (eval-expression expr-3) 11)

(define (eval-expression expr)
  (cond [(number? expr) expr]
        [(add? expr) (+ (eval-expression (add-left expr))
                        (eval-expression (add-right expr)))]
        [(mul? expr) (* (eval-expression (mul-left expr))
                        (eval-expression (mul-right expr)))]))






















