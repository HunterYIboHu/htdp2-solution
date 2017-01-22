;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex281-lambda-practice) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; data difinitions
(define-struct IR
  [name price])
; An IR is a structure:
;   (make-IR String Number)
; An Inventory is one of: 
; – '()
; – (cons IR Inventory)

(define ir-1 (make-IR "Apple" 2000))
(define ir-2 (make-IR "Juice" 3500))
(define ir-3 (make-IR "windos" 1500))
(define ir-4 (make-IR "Alibaba" 1899))


;;Exercise 281. Write down a lambda expression that 
;;consumes a number and decides whether it is less than 10;

(lambda (x) (< x 10))

;;> (filter (lambda (x) (< x 10)) '(10 20 5 8))
;;(list 5 8)


;;multiplies two given numbers and turns the result into a string;

(lambda (x y) (number->string (* x y)))

;;> (map (lambda (x y) (number->string (* x y))) '(1 2 3) '(10 9 8))
;;(list "10" "18" "24")


;;consumes two inventory records and compares them by price;

(lambda (ir-a ir-b) (<= (IR-price ir-a) (IR-price ir-b)))

;;> (map ((lambda (ir-b)
;;          (lambda (ir-a) (<= (IR-price ir-a) (IR-price ir-b)))) ir-1)
;;       `(,ir-1 ,ir-2 ,ir-3 ,ir-4))
;;(list #true #false #true #true)


;;consumes a natural number and produces 0 if it is even and 1 if odd;

(lambda (num) (cond [(even? num) 0]
                    [(odd? num) 1]
                    [else #false]))

;;> (map (lambda (num) (cond [(even? num) 0]
;;                           [(odd? num) 1]
;;                           [else #false])) '(1 2 3 4 5 10))
;;(list 1 0 1 0 1 0)


;;adds a red dot at a given Posn to a given Image.

(lambda (pos img) (local ((define DOT (circle 3 "solid" "red")))
                    (place-image DOT (posn-x pos) (posn-y pos) img)))


;;Demonstrate how to use these functions in the interactions area. 