;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex360-lookup-all-def) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; functions
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

