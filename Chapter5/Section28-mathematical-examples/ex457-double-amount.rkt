;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex457-double-amount) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; functions
; Number -> N
; computes the months need to double money at the given interest.
; assume (1) the interest is larger than 0
; (2) the interest is fixed.

(check-expect (double-amount 0.5) 2)
(check-expect (double-amount 0.1) 8)
(check-error (double-amount 0))

(define (double-amount interest)
  (local (; Number Number -> Number
          ; use a state value to determine whether current
          ; is doubled.
          (define (helper current i)
            (cond [(>= current 2) 0]
                  [else (add1 (helper (* current (add1 i)) i))]))
          )
    (if (> interest 0)
        (helper 1 interest)
        (error "The given interest shall larger than 0."))))