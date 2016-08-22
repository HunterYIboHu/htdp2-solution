;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 10.2-average) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-temperatures is one of:
; - '()
; - (cons CTemperature List-of-temperatures)

; A CTemperature is a Number greater or equal to -273


; List-of-temperatures -> Number
; computes the average temperature.
; examples:

(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)

(define (average alot)
  (/ (sum alot)
     (how-many alot)))


; List-of-temperatures -> Number
; adds up the temperatures on the given list

(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect (sum (cons 30 (cons 2 (cons 1111 (cons 3 '()))))) 1146)

(define (sum alot)
  (cond [(empty? alot) 0]
        [(cons? alot)
         (+ (first alot)
            (sum (rest alot)))]))


; List-of-temperatures -> Number
; counts the temperatures on the given list

(check-expect (how-many (cons 1 '())) 1)
(check-expect (how-many '()) 0)
(check-expect (how-many (cons 2 (cons 1 (cons 19 '())))) 3)

(define (how-many alot)
  (cond [(empty? alot) 0]
        [(cons? alot)
         (add1 (how-many (rest alot)))]))












