;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex354-eval-variable) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; BSL-var-expr -> Number
; produces the value of the given expr if numberic? yields #true, else signals
; error.

(check-expect (eval-variable expr-1) 3)
(check-expect (eval-variable expr-2) 11)
(check-error (eval-variable expr-3) WRONG)
(check-error (eval-variable expr-4) WRONG)

(define (eval-variable expr)
  (if (numberic? expr)
      (eval-expression expr)
      (error WRONG)))


; BSL-var-expr AL -> Number
; substitute all the variable with the corresponding value in the given al,
; then if numberic? yields #true, produces the value, else signals error.

(check-expect (eval-variable* expr-3 al-1) 3)
(check-expect (eval-variable* expr-4 al-2) 275)
(check-expect (eval-variable* expr-8 al-3) 34)
(check-error (eval-variable* expr-8 al-2) WRONG)

(define (eval-variable* expr al)
  (eval-variable (foldr (lambda (a base) (apply subst `(,base ,@a)))
                        expr
                        al)))


;; auxiliary functions
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


; BSL-expr -> Number
; produces the value of the given expr.

(check-expect (eval-expression 3) 3)
(check-expect (eval-expression expr-1) 3)
(check-expect (eval-expression expr-2) 11)

(define (eval-expression expr)
  (cond [(number? expr) expr]
        [(add? expr) (+ (eval-expression (add-left expr))
                        (eval-expression (add-right expr)))]
        [(mul? expr) (* (eval-expression (mul-left expr))
                        (eval-expression (mul-right expr)))]))


; BSL-var-expr Symbol Number -> BSL-var-expr
; produces an expression with all occurrences of x in ex replaced by v.

(check-expect (subst expr-3 'x 10) 10)
(check-expect (subst expr-6 'x 10) (make-add 10 3))
(check-expect (subst expr-7 'x 5) (make-mul 1/2 (make-mul 5 3)))
(check-expect (subst expr-8 'y 5) (make-add (make-mul 'x 'x)
                                            (make-mul 5 5)))

(define (subst ex x v)
  (cond [(symbol? ex)
         (if (symbol=? ex x) v ex)]
        [(number? ex) ex]
        [(add? ex) (make-add (subst (add-left ex) x v)
                             (subst (add-right ex) x v))]
        [(mul? ex) (make-mul (subst (mul-left ex) x v)
                             (subst (mul-right ex) x v))]))