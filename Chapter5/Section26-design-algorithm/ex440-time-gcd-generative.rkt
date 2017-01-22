;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex440-time-gcd-generative) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; functions
; N[>= 1] N[>= 1] -> N
; finds the greatest common divisor of n and m

(check-expect (gcd-generative 6 25) 1)
(check-expect (gcd-generative 18 24) 6)
(check-expect (gcd-generative 101135853 45014640) 177)

(define (gcd-generative n m)
  (local (; N[>= 1] N[>= 1] -> N
          ; generative recursion
          ; (gcd L S) == (gcd S (remainder L S))
          (define (clever-gcd L S)
            (cond [(zero? S) L]
                  [else (clever-gcd S (remainder L S))])))
    (clever-gcd (max m n) (min m n))))


;; test
(time (gcd-generative 101135853 45014640))