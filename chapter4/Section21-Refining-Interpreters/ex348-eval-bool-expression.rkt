;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex348-eval-bool-expression) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct and-s [left right])
; An And is:
;    (make-and-s BSL-expr/b BSL-expr/b)

(define-struct or-s [left right])
; An Or is:
;    (make-or-s BSL-expr/b BSL-expr/b)

(define-struct not-s [value])
; An Not is:
;    (make-not-s BSL-expr/b)

; BSL-expr/b is one of:
; - Boolean
; - And
; - Or
; - Not


;; constants
(define expr-1 (make-and-s #true #true)) ; #true
(define expr-2 (make-or-s #false #true)) ; #true
(define expr-3 (make-not-s #true)) ; #false
(define expr-4 (make-and-s (make-not-s #false)
                           (make-or-s #false #false))) ; #false


;; functions
; BSL-expr/b -> Boolean
; produces the given expr's value.

(check-expect (eval-bool-expression expr-1) #t)
(check-expect (eval-bool-expression expr-2) #t)
(check-expect (eval-bool-expression expr-3) #f)
(check-expect (eval-bool-expression expr-4) #f)

(define (eval-bool-expression expr)
  (cond [(boolean? expr) expr]
        [(and-s? expr) (and (eval-bool-expression (and-s-left expr))
                            (eval-bool-expression (and-s-right expr)))]
        [(or-s? expr) (or (eval-bool-expression (or-s-left expr))
                          (eval-bool-expression (or-s-right expr)))]
        [(not-s? expr) (not (eval-bool-expression (not-s-value expr)))]))


;; Questions
;; Q1: What kind of values do these Boolean expression yield?
;; A1: Boolean value.










