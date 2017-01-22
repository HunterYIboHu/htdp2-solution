;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex459-integrate-rect) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define ε 0.01)
(define R 160)

; Number -> Number
(define (constant x) 20)

; Number -> Number
(define (linear x) (* 2 x))

; Number -> Number
(define (square x) (* 3 (sqr x)))


;; functions
; [Number -> Number] Number Number -> Number
; produces the approximate area of the f between a and b.
; assume the (< a b) holds.

(check-within (integrate-rect constant 12 22) 200 ε)
(check-within (integrate-rect linear 0 10) 100 ε)
(check-within (integrate-rect square 0 10)
              1000
              ε)

(define (integrate-rect f a b)
  (local ((define W (/ (- b a) R))
          (define S (/ W 2))
          ; N -> Number
          ; help initialize the compute of rectangles' area.
          ; stops when (= i R)
          (define (helper i)
           (cond [(= i R) 0]
                 [else (+ (* W
                             (f (+ a
                                   (* i W)
                                   S)))
                          (helper (add1 i)))])))
    (helper 0)))


;; Questions
;; Q1: Make R a top-level constant and increase it by factors of 10
;; until the algorithm’s accuracy eliminates problems with
;; ε value of 0.1.
;; A1: 50.
;;
;; Q2: Decrease ε to 0.01 and increase R enough to eliminate any
;; failing test cases again
;; A2: 160.

