;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex246~249-comupting) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; functions
(define (extract R l t)
  (cond
    [(empty? l) '()]
    [else (cond
            [(R (first l) t)
             (cons (first l)
                   (extract R (rest l) t))]
            [else
             (extract R (rest l) t)])]))


(define (squared>? x a)
  (> (* x x) a))

(define (f x) x)

;; run functions
;Exercise 246. Check step 1 of the last calculation 
;(extract < (cons 6 (cons 4 '())) 5)
;==
;(extract < (cons 4 '()) 5)
;using DrRacket’s stepper.

;(extract < '(6 4) 5)

;Exercise 247. valuate (extract < (cons 8 (cons 4 '())) 5)
;with DrRacket’s stepper.

;(extract < (cons 8 (cons 4 '())) 5)

;Exercise 248. Evaluate (squared>? 3 10) and (squared>? 4 10)
;in DrRacket’s stepper.

;(squared>? 3 10)
;(squared>? 4 10)

;Exercise 249. 
;; run definitions
(cons f '())
(f f)
(cons f (cons 10 (cons (f 10) '())))