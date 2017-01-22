;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex357-eval-definition1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define WRONG "Invalid function apply!")

(define expr-1 `(k ,(make-add 1 1)))
(define expr-2 (make-mul 5 `(k ,(make-add 1 1))))
(define expr-3 (make-mul '(i 5)
                         `(k ,(make-add 1 1))))
(define expr-6 (make-add 'x 3))
(define expr-7 (make-mul 1/2 (make-mul 'x 3)))
(define expr-8 (make-add (make-mul 'x 'x)
                         (make-mul 'y 'y)))


;; functions
; BSL-func-expr Symbol Symbol BSL-func-expr -> Number
; produces the value of given expr, the f represents the function's name;
; x represents the function's parameter, b represents the function's body.
; it signal errors when the two case happended one:
; - encounters variable
; - function application does not refer to f.

(check-expect (eval-definition1 expr-1 'k 'a (make-mul 'a 2)) 4)
(check-expect (eval-definition1 expr-2 'k 'a (make-mul 'a 2)) 20)
(check-error (eval-definition1 expr-1 'i 'a (make-mul 'a 2)) WRONG)
(check-error (eval-definition1 expr-6 'i 'a (make-mul 'a 2)) WRONG)

(define (eval-definition1 ex f x b)
  (local (; BSL-func-expr -> Number
          ; using arguments of outside function to simpfy the application.
          (define (apply-func expr)
            (eval-definition1 expr f x b))
          ; [Number Number -> Number] BSL-func-expr BSL-func-expr -> Number
          ; iter the given two pieces of data.
          (define (iter f left right)
            (f (apply-func left) (apply-func right))))
    (cond [(cons? ex)
           (if (symbol=? (first ex) f)
               (apply-func (subst b x (second ex)))
               (error WRONG))]
          [(symbol? ex) (error WRONG)]
          [(number? ex) ex]
          [(add? ex) (iter + (add-left ex) (add-right ex))]
          [(mul? ex) (iter * (mul-left ex) (mul-right ex))])))


;; auxiliary functions
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
                             (subst (mul-right ex) x v))]))

