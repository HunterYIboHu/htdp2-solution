;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex279-lambda-expr-legal) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 279. Decide which of the following phrases are legal lambda expressions: 
; 1. (lambda (x y) (x y y))

;; A: It's legal expression, for the arguments could be function, if x belongs
;; to functions, the lambda expr could be compute.

;; examples:
;; > ((lambda (x y) (x y y)) + 10)
;; 20


; 2. (lambda () 10)

;; A: It's illegal expression, for the disappearence of arguments. The lambda
;; expr need at least one argument or more.

;; examples:
;; > (lambda () 10)
;; lambda: expected (lambda (variable more-variable ...) expression), but
;; found no variables


; 3. (lambda (x) x)

;; A: It's legal expression. There is one argument and one expression using
;; it.

;; examples:
;; > ((lambda (x) x) 10)
;; 10


; 4. (lambda (x y) x)

;; A: It's legal expression, though there is one argument haven't used, the
;; syntax regard this.

;; examples:

;; > ((lambda (x y) x) 10 15)
;; 10


; 5. (lambda x 10)

;; A: It's illegal expression. There is no parentheses around the arguments.


;Explain why they are legal or illegal. If in doubt, experiment in the interactions area of DrRacket. 