;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex351-interpreter-expr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An Atom is one of: 
; – Number
; – String
; – Symbol


; An S-expr is one of: 
; – Atom
; – SL


; An SL is one of: 
; – '()
; – (cons S-expr SL)

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

; An Expression is one of:
; - Number
; - (+ Expression Expression)
; - (* Expression Expression)


;; constants
(define WRONG "not implement!")

(define expr-1 (make-add 1 1))
(define expr-2 (make-mul 3 10))
(define expr-3 (make-add (make-mul 1 1) 10))

(define s-1 '(+ 1 1))
(define s-2 '(* 3 10))
(define s-3 '(+ (* 1 1) 10))


;; functions
; S-expr -> Expression
; produces the given s-expr's value, if parse recognizes them as BSL-expr.

(check-expect (interpreter-expr s-1) 2)
(check-expect (interpreter-expr s-2) 30)
(check-expect (interpreter-expr s-3) 11)
(check-error (interpreter-expr '(- 1)))

(define (interpreter-expr s)
  (eval-expression (parse s)))


; BSL-expr -> Number
; produces the value of the given expr.

(check-expect (eval-expression 3) 3)
(check-expect (eval-expression expr-1) 2)
(check-expect (eval-expression expr-2) 30)
(check-expect (eval-expression expr-3) 11)

(define (eval-expression expr)
  (cond [(number? expr) expr]
        [(add? expr) (+ (eval-expression (add-left expr))
                        (eval-expression (add-right expr)))]
        [(mul? expr) (* (eval-expression (mul-left expr))
                        (eval-expression (mul-right expr)))]))


; S-expr -> BSL-expr

; for correctness
(check-expect (parse s-1) expr-1)
(check-expect (parse s-2) expr-2)
(check-expect (parse s-3) expr-3)

; for parse-atom
(check-error (parse ""))
(check-error (parse '-))

; for parse-sl's error.
(check-error (parse '(+ 1)))
(check-error (parse '(- 1 2)))
(check-error (parse '(+ 1 2 3 4)))

(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))


(define (parse-sl s)
  (local ((define L (length s)))
    (cond
      [(< L 3) (error WRONG)]
      [(and (= L 3) (symbol? (first s)))
       (local (; [BSL-expr BSL-expr -> BSL-expr] -> BSL-expr
               ; prodcues another expr according to the function.
               (define (parse/func func)
                 (func (parse (second s)) (parse (third s)))))
         (cond
           [(symbol=? (first s) '+)
            (parse/func make-add)]
           [(symbol=? (first s) '*)
            (parse/func make-mul)]
           [else (error WRONG)]))]
      [else (error WRONG)])))

 
; Atom -> BSL-expr 
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))


;; auxiliary functions
; X -> Boolean
; determine whether the given x is an Atom.

(check-expect (atom? 100) #true)
(check-expect (atom? "hello") #true)
(check-expect (atom? 'a) #true)
(check-expect (atom? #false) #false)

(define (atom? x)
  (or (number? x)
      (string? x)
      (symbol? x)))