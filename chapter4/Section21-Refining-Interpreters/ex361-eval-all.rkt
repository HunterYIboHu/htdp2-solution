;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex361-eval-all) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; BSL-fun-expr is one of:
; - Number
; - Symbol
; - Add
; - Mul
; - Func

; BSL-func-def* is [List-of Func]

; BSL-da-all is (append [List-of Association] [List-of Func])


;; constants
(define WRONG-1 "No such function definition can be found")
(define WRONG-2 "No such constant definition can be found")

(define con-1 '((x 10) (y 5) (z 20)))
(define con-2 '((x 13)))

(define f (make-func 'f 'x (make-add 3 'x)))
(define g (make-func 'g 'y `(f ,(make-mul 2 'y))))
(define h (make-func 'h 'v (make-add '(f v) '(g v))))

(define functions `(,f ,g ,h))

(define da-1 `(,@con-1 ,@functions))

(define expr-f (make-add `(f ,(make-mul 2 5))
                         10))
(define expr-g `(g (f ,(make-add 2 1))))
(define expr-h `(h ,(make-mul '(f 10)
                              `(g ,(make-add 1 1)))))
(define expr-i `(h ,(make-mul '(f x)
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
; BSL-fun-expr BSL-da-all -> Number
; produces the value of the given expr, otherwise signals error
; when one of following case happend: 
; - No such function definition can be found
; - No such constant definition can be found

(check-expect (eval-all expr-f da-1) 23)
(check-expect (eval-all expr-g da-1) 15)
(check-expect (eval-all expr-h da-1) 279)
(check-expect (eval-all expr-i da-1) 279)
(check-error (eval-all 'no-con da-1) WRONG-2)
(check-error (eval-all '(no-fun 10) da-1) WRONG-1)

(define (eval-all ex da)
  (local (; BSL-fun-expr -> Number
          ; help simpfy the function apply.
          (define (apply-func expr)
            (eval-all expr da))
          ; [Number Number -> Number] BSL-fun-expr BSL-fun-expr -> Number
          ; help simpfy the iter of function apply.
          (define (iter func left right)
            (func (apply-func left) (apply-func right))))
    (cond [(cons? ex)
           (local ((define one-f (lookup-fun-def da (first ex))))
             ; there will signals an error when happens.
             (eval-all (subst (func-body one-f)
                              (func-args one-f)
                              (second ex))
                       da))]
          [(symbol? ex) (second (lookup-con-def da ex))]
          [(number? ex) ex]
          [(add? ex) (iter + (add-left ex) (add-right ex))]
          [(mul? ex) (iter * (mul-left ex) (mul-right ex))])))


;; auxiliary functions
; BSL-da-all Symbol ->  Assoication
; produces the representation of a constant definition whose name is x; otherwise
; signals an error.

(check-expect (lookup-con-def da-1 'y) '(y 5))
(check-expect (lookup-con-def da-1 'x) '(x 10))
(check-error (lookup-con-def da-1 'f) WRONG-2)
(check-error (lookup-con-def `(,@con-2 ,@functions) 'y) WRONG-2)

(define (lookup-con-def da x)
  (local ((define result
            (filter (lambda (item) (and (cons? item)
                                        (symbol=? x (first item)))) da)))
    (if (empty? result)
        (error WRONG-2)
        (first result))))


; BSL-da-all Symbol -> Func
; produces the representation of a function definition whose name is x; otherwise
; signals an error.

(check-expect (lookup-fun-def da-1 'f) f)
(check-expect (lookup-fun-def da-1 'h) h)
(check-error (lookup-fun-def da-1 'x) WRONG-1)
(check-error (lookup-fun-def da-1 'i) WRONG-1)

(define (lookup-fun-def da f)
  (lookup-def (filter (lambda (item) (func? item)) da) f))


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