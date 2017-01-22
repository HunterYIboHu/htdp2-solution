;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex401-sexp-equal) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An S-expr (S-expression) is one of: 
; – Atom
; – [List-of S-expr]
; 
; An Atom is one of: 
; – Number
; – String
; – Symbol


;; constants
(define s1 '(+ 1 2))
(define s2 `(+ ,s1 (sub1 3)))


;; functions
; S-expr S-expr -> Boolean
; determine whether the two se is the same one.

(check-expect (sexp=? s1 s1) #true)
(check-expect (sexp=? s1 s2) #false)
(check-expect (sexp=? s2 s2) #true)
(check-expect (sexp=? '(+ 1 2 3 4) '(+ 1 2)) #false)
(check-expect (sexp=? '(+ 1 2) '(+ 1 2 3)) #false)
(check-expect (sexp=? '(+ 1 2) 1) #false)

(define (sexp=? se-1 se-2)
  (cond [(and (atom? se-1) (atom? se-2)) (equal? se-1 se-2)]
        [(and (atom? se-1) (cons? se-2)) #false]
        [(and (cons? se-1) (atom? se-2)) #false]
        [(and (empty? se-1) (cons? se-2)) #false]
        [(and (empty? se-1) (empty? se-2)) #true]
        [(and (cons? se-1) (empty? se-2)) #false]
        [(and (cons? se-1) (cons? se-2))
         (and (sexp=? (first se-1) (first se-2))
              (sexp=? (rest se-1) (rest se-2)))]))


;; auxiliary functions
; X -> Boolean
; determine whether the input is Atom.

(check-expect (atom? s1) #false)
(check-expect (atom? "a") #true)
(check-expect (atom? 's) #true)
(check-expect (atom? 1) #true)
(check-expect (atom? #true) #false)

(define (atom? input)
  (or (number? input)
      (string? input)
      (symbol? input)))

