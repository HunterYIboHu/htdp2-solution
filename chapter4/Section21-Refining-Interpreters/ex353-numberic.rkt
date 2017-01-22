;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex353-numberic) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; BSL-var-expr is one of:
; - Number
; - Symbol
; - Add
; - Mul

; An Expression is one of:
; - Number
; - (+ Expression Expression)
; - (* Expression Expression)


;; constants
(define expr-1 3)
(define expr-2 (make-add 3 (make-mul 4 2)))
(define expr-3 'x)
(define expr-4 (make-add 100 (make-mul (make-add 4 3)
                                       (make-mul 'x 5))))


;; functions
; BSL-var-expr -> Boolean
; determine whether the given ex is BSL-expr.

(check-expect (numberic? expr-1) #t)
(check-expect (numberic? expr-2) #t)
(check-expect (numberic? expr-3) #f)
(check-expect (numberic? expr-4) #f)

(define (numberic? expr)
  (cond [(number? expr) #true]
        [(add? expr) (and (numberic? (add-left expr))
                          (numberic? (add-right expr)))]
        [(mul? expr) (and (numberic? (mul-left expr))
                          (numberic? (mul-right expr)))]
        [else #false]))











