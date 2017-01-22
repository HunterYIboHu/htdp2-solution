;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex415-find-max-exponent) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N -> N
; produces the integer which (expt #i10.0 (add1 n))
; is approximated with +inf.0.

(check-expect (max-exponent 0) 308)
(check-expect (max-exponent 400) 308)

(define (max-exponent num)
  (local ((define equal-inf (= +inf.0 (expt #i10.0 num)))
          (define large-than-expected
            (> +inf.0 (expt #i10.0 (sub1 num)))))
    (if (and equal-inf
             large-than-expected)
        (sub1 num)
        (if large-than-expected
            (max-exponent (add1 num))
            (max-exponent (sub1 num))))))
