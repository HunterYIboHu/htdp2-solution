;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex306-for-loop-exercise) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 306. Use loops to define a function that 
;creates the list (list 0 ... (- n 1)) for any natural number n;
;creates the list (list 1 ... n) for any natural number n;
;creates the list (list 1 1/10 ... 1/n) for any natural number n;
;creates the list of the first n even numbers;
;creates a diagonal square of 0s and 1s; see exercise 262.
;Finally, use loops to define tabulate from exercise 250.
(require 2htdp/abstraction)


; N -> [List-of N]
; creates the list (list 0 ... (- n 1)) for any natural number n

(check-expect (range-n 10) (range 0 10 1))
(check-expect (range-n 100) (range 0 100 1))

(define (range-n n)
  (for/list ([num n])
    num))


; N -> [List-of N]
; creates the list (list 1 ... n) for any natural number n

(check-expect (index-n 10) (range 1 11 1))
(check-expect (index-n 100) (range 1 101 1))

(define (index-n n)
  (for/list ([num n])
    (add1 num)))


; N -> [List-of N]
; creates the list (list 1 1/10 ... 1/n) for any natural number n;

(check-expect (div1-to-expt-10 2) '(1 1/10))
(check-expect (div1-to-expt-10 3) '(1 1/10 1/100))

(define (div1-to-expt-10 n)
  (for/list ([num n])
    (expt 10 (- 0 num))))


; N -> [List-of N]
; create the list of the first n even numbers

(check-expect (even-generater 5) '(0 2 4 6 8))
(check-expect (even-generater 2) '(0 2))

(define (even-generater n)
  (for/list ([num n])
    (* num 2)))


; Number -> [List-of [List-of Number]]
; creates a list of list of 0 and 1 in a diagonal arrangement

(check-expect (diagonal 0) '())
(check-expect (diagonal 1) (list (list 1)))
(check-expect (diagonal 4) (list
                            (list 1 0 0 0)
                            (list 0 1 0 0)
                            (list 0 0 1 0)
                            (list 0 0 0 1)))
(check-expect (diagonal 5) (list
                            (list 1 0 0 0 0)
                            (list 0 1 0 0 0)
                            (list 0 0 1 0 0)
                            (list 0 0 0 1 0)
                            (list 0 0 0 0 1)))

(define (diagonal n)
  (for/list ([i n])
    (for/list ([j n])
      (if (= i j) 1 0))))


; Number [Number -> X] - > [List-of X]
; tabulates function f between n and 0 in a list (both inclusive)

(check-expect (tabulate 4 identity) (list 4 3 2 1 0))
(check-expect (tabulate 3 add1) '(4 3 2 1))

(define (tabulate n func)
  (reverse (for/list ([num (add1 n)])
             (func num))))

