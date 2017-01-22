;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname for-and) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


; X [X -> [Maybe X]] -> [Maybe X]
; re-formulate for/and

(check-expect (for/and-v2 10 (lambda (i) (> (- 9 i) 0)))
              (for/and ([i 10]) (> (- 9 i) 0)))
(check-expect (for/and-v2 10 (lambda (i) (if (>= i 0) i #false)))
              (for/and ([i 10]) (if (>= i 0) i #false)))
(check-expect (for/and-v2 '(1 2 3) (lambda (c) (if (> c 4) c #false)))
              (for/and ([c '(1 2 3)]) (if (> c 4) c #false)))
(check-expect (for/and-v2 '(1 2 3) (lambda (c) (if (< c 4) c #false)))
              (for/and ([c '(1 2 3)]) (if (< c 4) c #false)))

(define (for/and-v2 i func)
  (local ((define list-result (for/list ([x i])
                                (func x))))
    (if (andmap false? list-result)
        #false
        (last list-result))))


; [List-of X] -> X
; return the last item of the given list.

(check-expect (last '(1 2 3)) 3)
(check-expect (last '("string" "buffer" "nothing")) "nothing")

(define (last l)
  (cond [(empty? (rest l)) (first l)]
        [else (last (rest l))]))