;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex439-time-gcd-structural) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; test
(time (gcd-structural 101135853 45014640))