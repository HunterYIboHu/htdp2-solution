;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex359-eval-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;    (make-func Symbol Symbol BSL-fun-expr)

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
(define WRONG-1 "No correspond function definition.")
(define WRONG-2 "encounters variable")

(define f (make-func 'f 'x (make-add 3 'x)))
(define g (make-func 'g 'y `(f ,(make-mul 2 'y))))
(define h (make-func 'h 'v (make-add '(f v) '(g v))))

(define functions `(,f ,g ,h))

(define expr-f (make-add `(f ,(make-mul 2 5))
                         10))
(define expr-g `(g (f ,(make-add 2 1))))
(define expr-h `(h ,(make-mul '(f 10)
                              `(g ,(make-add 1 1)))))

(define expr-1 `(k ,(make-add 1 1)))
(define expr-2 (make-mul 5 `(k ,(make-add 1 1))))
(define expr-3 (make-mul '(i 5)
                         `(k ,(make-add 1 1))))
(define expr-6 (make-add 'x 3))
(define expr-7 (make-mul 1/2 (make-mul 'x 3)))
(define expr-8 (make-add (make-mul 'x 'x)
                         (make-mul 'y 'y)))


;; functions
; BSL-fun-expr BSL-fun-def* -> Number
; produces the value of ex if all difinitions can find in da.

(check-expect (eval-function* expr-f functions) 23)
(check-expect (eval-function* expr-g functions) 15)
(check-expect (eval-function* expr-h functions) 279)
(check-error (eval-function* expr-8 functions) WRONG-2)
(check-error (eval-function* '(10 10) functions) WRONG-1)

(define (eval-function* ex da)
  (cond [(cons? ex)
         (if (symbol? (first ex))
             (eval-function* (subst (func-body (lookup-def functions (first ex)))
                                    (func-args (lookup-def functions (first ex)))
                                    (second ex))
                             da)
             (error WRONG-1))]
        [(symbol? ex) (error WRONG-2)]
        [(number? ex) ex]
        [(add? ex) (+ (eval-function* (add-left ex) da)
                      (eval-function* (add-right ex) da))]
        [(mul? ex) (* (eval-function* (mul-left ex) da)
                      (eval-function* (mul-right ex) da))]))


;; auxiliary functions
; BSL-fun-def* Symbol -> Func
; retrieves the definition of f in da signals an error if there is none.

(check-expect (lookup-def functions 'f) f)
(check-expect (lookup-def functions 'h) h)
(check-error (lookup-def functions 'k) WRONG-1)

(define (lookup-def da f)
  (local ((define result (filter (lambda (one-f) (symbol=? f (func-name one-f)))
                                 da)))
    (if (empty? result)
        (error WRONG-1)
        (first result))))


; BSL-var-expr Symbol Number -> BSL-var-expr
; produces an expression with all occurrences of x in ex replaced by v.

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
                             (subst (mul-right ex) x v))]
        [(cons? ex) `(,(first ex) ,(subst (second ex) x v))]))

