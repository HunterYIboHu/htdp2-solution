;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex358-lookup-def) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

(define-struct add [left right])
; An Add is a structure:
;    (make-add BSL-fun-expr BSL-fun-expr)

(define-struct mul [left right])
; An Mul is a structure:
;    (make-mul BSL-fun-expr BSL-fun-expr)

(define-struct func [name args body])
; An Func is a structure:
;    (make-func Symbol [List-of Symbol] BSL-fun-expr)

; BSL-expr is one of:
; - Number
; - Add
; - Mul

; BSL-var-expr is one of:
; - Number
; - Symbol
; - Add
; - Mul

; BSL-fun-expr is one of:
; - Number
; - Symbol
; - Add
; - Mul
; - Func

; BSL-func-def* is [List-of Func]


;; constants
(define WRONG "No correspond function definition.")

(define f (make-func 'f 'x (make-add 3 'x)))
(define g (make-func 'g 'y `(f ,(make-mul 2 'y))))
(define h (make-func 'h 'v (make-add '(f v) '(g v))))

(define functions `(,f ,g ,h))

;; functions
; BSL-fun-def* Symbol -> Func
; retrieves the definition of f in da signals an error if there is none.

(check-expect (lookup-def functions 'f) f)
(check-expect (lookup-def functions 'h) h)
(check-error (lookup-def functions 'k) WRONG)

(define (lookup-def da f)
  (local ((define result (filter (lambda (one-f) (symbol=? f (func-name one-f)))
                                 da)))
    (if (empty? result)
        (error WRONG)
        (first result))))

