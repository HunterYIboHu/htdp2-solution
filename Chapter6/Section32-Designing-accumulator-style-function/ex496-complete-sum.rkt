;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex496-complete-sum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> Number
; computes the sum of all numbers on the list.

(check-expect (sum '(1 2 5 6)) 14)
(check-expect (sum '(1 -1 0)) 0)

(define (sum alon0)
  (local (; [List-of Number] ??? -> Number
          ; compute the sum of the numbers on alon.
          ; accumulator a is the sum of the numebers on alon
          ; that lacks from alon0.
          (define (sum/a alon a)
            (cond [(empty? alon) a]
                  [else (sum/a (rest alon)
                               (+ (first alon) a))])))
    (sum/a alon0 0)))


;; the process of sum.
;;(sum '(10 4))
;;== (sum/a '(10 4) 0)
;;== (sum/a '(4) (+ 10 0))
;;== (sum/a '() (+ 4 (+ 10 0)))
;;== (+ 4 (+ 10 0))
;;== 14