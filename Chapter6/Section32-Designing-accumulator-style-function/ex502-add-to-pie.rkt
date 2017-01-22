;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex502-add-to-pie) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; N -> Number 
; add n to pi without use +

(check-within (add-to-pi 2) (+ 2 pi) 0.001)
(check-within (add-to-pi 10) (+ 10 pi) 0.001)
(check-within (add-to-pi 0) pi 0.001)

(define (add-to-pi n0)
  (local (; N Number -> Number
          ; produces the result of add n to pi.
          ; accumulator r is a number represent the sum of
          ; the distance of n0 and n add to pi.
          (define (add-to-pi/a n r)
            (cond [(zero? n) r]
                  [else (add-to-pi/a (sub1 n)
                                     (add1 r))]))
          )
    (add-to-pi/a n0 pi)))