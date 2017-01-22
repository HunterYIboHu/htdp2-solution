;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex352-subst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct add [left right])
; An Add is a structure:
;    (make-add BSL-var-expr BSL-var-expr)

(define-struct mul [left right])
; An Mul is a structure:
;    (make-mul BSL-var-expr BSL-var-expr)

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
(define expr-1 'x)
(define expr-2 (make-add 'x 3))
(define expr-3 (make-mul 1/2 (make-mul 'x 3)))
(define expr-4 (make-add (make-mul 'x 'x)
                         (make-mul 'y 'y)))


;; functions
; BSL-var-expr Symbol Number -> BSL-var-expr
; produces an expression with all occurrences of x in ex replaced by v.

(check-expect (subst expr-1 'x 10) 10)
(check-expect (subst expr-2 'x 10) (make-add 10 3))
(check-expect (subst expr-3 'x 5) (make-mul 1/2 (make-mul 5 3)))
(check-expect (subst expr-4 'y 5) (make-add (make-mul 'x 'x)
                                            (make-mul 5 5)))

(define (subst ex x v)
  (cond [(symbol? ex)
         (if (symbol=? ex x) v ex)]
        [(number? ex) ex]
        [(add? ex) (make-add (subst (add-left ex) x v)
                             (subst (add-right ex) x v))]
        [(mul? ex) (make-mul (subst (mul-left ex) x v)
                             (subst (mul-right ex) x v))]))

