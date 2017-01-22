;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex355-eval-var-lookup) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

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
(define WRONG "Not implement!")

(define al-1 '((x 3)))
(define al-2 '((x 5)))
(define al-3 '((x 5) (y 3)))

(define expr-1 3)
(define expr-2 (make-add 3 (make-mul 4 2)))
(define expr-3 'x)
(define expr-4 (make-add 100 (make-mul (make-add 4 3)
                                       (make-mul 'x 5))))
(define expr-5 (make-add 'x (make-mul (make-add 4 'y)
                                      (make-mul 'x 'x))))
(define expr-6 (make-add 'x 3))
(define expr-7 (make-mul 1/2 (make-mul 'x 3)))
(define expr-8 (make-add (make-mul 'x 'x)
                         (make-mul 'y 'y)))


;; functions
; BSL-var-expr AL -> Number
; produces the value of the given expression. when find a symbol x,
; use assq to look up the value of x in the association list. If there is no
; value, signals an error.

(check-expect (eval-var-lookup expr-3 al-1) 3)
(check-expect (eval-var-lookup expr-4 al-2) 275)
(check-expect (eval-var-lookup expr-8 al-3) 34)
(check-error (eval-var-lookup expr-8 al-2) WRONG)

(define (eval-var-lookup e da)
  (local (;[Number Number -> Number] BSL-var-expr -> Number
          ; help iter the function.
          (define (iter func left right)
            (func (eval-var-lookup left da)
                  (eval-var-lookup right da))))
    (cond [(symbol? e) (local ((define pair (assq e da)))
                         (if (cons? pair)
                             (second pair)
                             (error WRONG)))]
          [(number? e) e]
          [(add? e) (iter + (add-left e) (add-right e))]
          [(mul? e) (iter * (mul-left e) (mul-right e))])))

