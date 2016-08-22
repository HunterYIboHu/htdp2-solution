;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex145-NEList) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 145. Would sum and how-many work for NEList-of-temperatures even 
; if they were designed for inputs from List-of-temperatures?
; If you think they don’t work, provide counter-examples.
; If you think they would, explain why.

; Answer: They would. These functions are designed for any list that
; consists of numbers, no matter what the list is empty or not.


; ---


; A CTemperature is a Number greater or equal to -273

; A NEList-of-temperatures is one of:
; - (cons CTemperature '())
; - (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of measured temperatures


; NEList-of-temperatures -> Number
; computes the average temperature

(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)

(define (average anelot)
  (/ (sum anelot)
     (how-many anelot)))


; NEList-of-temperatures -> Number
; adds up the temperatures on the given list

(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect (sum (cons 30 (cons 2 (cons 1111 (cons 3 '()))))) 1146)

(define (sum anelot)
  (cond [(empty? (rest anelot)) (first anelot)]
        [(cons? (rest anelot)) (+ (first anelot) (sum (rest anelot)))]))


; NEList-of-temperatures -> Number
; counts the temperatures on the given list

(check-expect (how-many (cons 1 '())) 1)
(check-expect (how-many (cons 2 (cons 1 (cons 19 '())))) 3)

(define (how-many anelot)
  (cond [(empty? (rest anelot)) 1]
        [(cons? (rest anelot)) (add1 (how-many (rest anelot)))]))
