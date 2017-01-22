;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex349-test-parse) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
 
; SL -> BSL-expr 
(define (parse-sl s)
  (local ((define L (length s)))
    (cond
      [(< L 3) (error WRONG)]
      [(and (= L 3) (symbol? (first s)))
       (cond
         [(symbol=? (first s) '+)
          (make-add (parse (second s)) (parse (third s)))]
         [(symbol=? (first s) '*)
          (make-mul (parse (second s)) (parse (third s)))]
         [else (error WRONG)])]
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