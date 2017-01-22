;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex444-gcd-another-version) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; functions
; N[>= 1] N[>= 1] -> N
; computes the largest common divisor of the given n and m

(check-expect (gcd-structural 10 20) 10)
(check-expect (gcd-structural 18 24) 6)
(check-expect (gcd-structural 18 35) 1)

(define (gcd-structural n m)
  (local ((define S (min n m))
          (define L (max n m)))
    (largest-common (divisors S S) (divisors S L))))
 
; N[>= 1] N[>= 1] -> [List-of N]
; computes the divisors of l smaller or equal to k

(check-expect (divisors 1 1) '(1))
(check-expect (divisors 10 20) '(10 5 4 2 1))
(check-expect (divisors 20 20) '(20 10 5 4 2 1))
(check-expect (divisors 5 23) '(1))

(define (divisors k l)
  (cond [(zero? k) '()]
        [else (if (= 0 (remainder l k))
                  (cons k (divisors (sub1 k) l))
                  (divisors (sub1 k) l))]))
 
; [List-of N] [List-of N] -> N
; finds the largest number common to both k and l

(check-expect (largest-common '(1 2 3 6)
                              '(1 2 3 4 6 12))
              6)
(check-expect (largest-common '(18 9 6 3 2 1)
                              '(12 8 6 4 3 2 1))
              6)

(define (largest-common k l)
  (apply max (filter (lambda (num) (and (member? num k)
                                        (member? num l)))
                     (append k l))))


;; Questions
;; Q1: Why do you think divisors consumes two numbers?
;; A1: Because the divisors which larger than the smaller argument is
;; not need for computing.
;;
;; Q2: Why does it consume S as the first argument in both uses?
;; A2: Because the smaller number of two function call is the same
;; number.