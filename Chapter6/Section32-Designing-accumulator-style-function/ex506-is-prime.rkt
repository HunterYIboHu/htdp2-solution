;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex506-is-prime) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N -> Boolean
; determines whether n0 is a prime.

(check-expect (is-prime 100) #f)
(check-expect (is-prime 1001) #f)
(check-expect (is-prime 17) #t)
(check-expect (is-prime 29989) #t)

(define (is-prime n0)
  (local (; N [List-of N] -> Boolean
          ; determines whetehr n is prime.
          ; accumulator divs represents all numbers :
          ; (1) not be divided by n;
          ; (2) not be times of the divs before.
          (define (is-prime/a n need-to-div)
            (cond [(empty? need-to-div) #true]
                  [else (local ((define current-div (first need-to-div))
                                ; N -> Boolean
                                ; determine whether num is divisable by current-div.
                                (define (divisable num)
                                  (= 0 (modulo num current-div))))
                          (if (divisable n)
                              #false
                              (is-prime/a n
                                          (filter (lambda (num) (not (divisable num)))
                                                  need-to-div))))])))
    (is-prime/a n0 (range 2 n0 1))))