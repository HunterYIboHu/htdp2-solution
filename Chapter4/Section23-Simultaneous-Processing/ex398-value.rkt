;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex398-value) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; A LC(short for linear combination) is [List-of Number]
; interpretation means a fixed order of variables' coefficient.

; A VV(short for variable values) is [List-of Number]
; interpretation means a fixed numebr of variables' value.


;; constants
(define lc-1 '(5))
(define lc-2 '(5 17))
(define lc-3 '(5 17 3))

(define vv-1 '(10))
(define vv-2 '(10 1))
(define vv-3 '(10 1 2))


;; functions
; LC VV -> Number
; computes the value of the combination for these values.

(check-expect (value lc-1 vv-1) 50)
(check-expect (value lc-2 vv-2) 67)
(check-expect (value lc-3 vv-3) 73)
(check-expect (value '() '()) 0)
(check-error (value lc-2 vv-3))
(check-error (value lc-2 vv-1))

(define (value lc vv)
  (cond [(and (empty? lc) (empty? vv)) 0]
        [(and (empty? lc) (cons? vv))
         (error "the amount of variable value is more than that of variables.")]
        [(and (cons? lc) (empty? vv))
         (error "the amount of variable is more than that of variables' value.")]
        [(and (cons? lc) (cons? vv))
         (+ (* (first lc) (first vv))
            (value (rest lc) (rest vv)))]))

