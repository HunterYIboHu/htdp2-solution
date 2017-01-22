;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex438-gcd-structural) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; functions
; N[>= 1] N[>= 1] -> N
; finds the greatest common divisor of n and m

(check-expect (gcd-structural 6 25) 1)
(check-expect (gcd-structural 18 24) 6)

(define (gcd-structural n m)
  (local (; N -> N
          ; determines the gcd of n and m less than i
          (define (greatest-divisor-<= i)
            (cond [(= i 1) 1]
                  [else (if (= (remainder n i) (remainder m i) 0)
                            i
                            (greatest-divisor-<= (sub1 i)))])))
    (greatest-divisor-<= (min n m))))


;; Questions
;; Q1: how does greatest-divisor-<= work?
;; A1: First, find the "evenly divisible" number i, and then return it;
;; if not, then sub i 1 and continue the first step.
;;
;; Q2: Why does the locally defined greatest-divisor-<= recur on
;; (min n m)?
;; A2: Because the gcd should less than or equal to the minist number
;; of the two.