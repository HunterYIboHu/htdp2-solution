;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex505-to10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of [0-9]] -> [Maybe N]
; produces the corresponding number represent i_1 X 10^(n-1) +
; i_2 X 10^(n-2) + ... + i_n X 10^0.
; it returns #false when the lon0 is empty.

(check-expect (to10 '(1 0 2)) 102)
(check-expect (to10 '(9 8 7 0 3)) 98703)
(check-expect (to10 '(0 0 0 1)) 1)
(check-expect (to10 '()) #false)

(define (to10 lon0)
  (local (; [List-of [0-9]] -> N
          ; produces the corresponding number of lon.
          ; accumulator d represent the 10's degree of the (first lon)
          ; accumulator num represent the corresponding number
          ; represent by the part from lon0 to lon.
          (define (to10/a lon d num)
            (cond [(empty? lon) num]
                  [else (to10/a (rest lon)
                                (sub1 d)
                                (+ num (* (first lon) (expt 10 d))))]))
          )
    (if (empty? lon0)
        #false
        (to10/a lon0 (sub1 (length lon0)) 0))))