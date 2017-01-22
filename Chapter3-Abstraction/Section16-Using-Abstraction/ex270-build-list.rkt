;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex270-build-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #f)))
; N -> [List-of N]
; produces the list `(0 1 ... ,(sub1 n)) for the given num

(check-expect (range-list 10) `(0 1 2 3 4 5 6 7 8 9))
(check-expect (range-list 5) `(0 1 2 3 4))

(define (range-list num)
  (build-list num identity))


; N -> [List-of N]
; produces the list `(0 1 ... ,n) for the given num.

(check-expect (n-list 10) '(1 2 3 4 5 6 7 8 9 10))
(check-expect (n-list 5) '(1 2 3 4 5))

(define (n-list num)
  (build-list num add1))


; N -> [List-of Number]
; produces the list `(1 1/10 1/100 ... 1/,(expt 10 (sub1 n)))
; for the given num

(check-expect (expt-list 3) '(1 1/10 1/100))
(check-expect (expt-list 5) '(1 1/10 1/100 1/1000 1/10000))

(define (expt-list num)
  (local (; N -> Number
          ; produces the 10's power's reciprocal by the given num.
          (define (expt-10 num)
            (/ 1 (expt 10 num))))
    (build-list num expt-10)))


; N -> [List-of N]
; produces the list of the first n even numbers.

(check-expect (even-list 4) '(0 2 4 6))
(check-expect (even-list 8) '(0 2 4 6 8 10 12 14))

(define (even-list n)
  (local (; N -> N
          ; create the nth even number, start from 0.
          (define (create-even n)
            (* 2 n)))
    (build-list n create-even)))


; N -> [List-of [List-of N]]
; create a diagonal square of 0s and 1s

(check-expect (identityM 1) `(,'(1)))
(check-expect (identityM 3) '((1 0 0) (0 1 0) (0 0 1)))
(check-expect (identityM 5)
              '((1 0 0 0 0) (0 1 0 0 0) (0 0 1 0 0) (0 0 0 1 0) (0 0 0 0 1)))

(define (identityM n)
  (local ((define NUM 1)
          (define origin (make-list n (make-list (sub1 n) 0)))
          ; N [List-of N] -> [List-of N]
          ; insert NUM on the given position of given list.
          (define (insert pos l)
            (cond [(= pos 0) (cons NUM l)]
                  [else (cons (first l)
                              (insert (sub1 pos) (rest l)))]))
          ; N -> [List-of [List-of N]]
          ; call insert at N pos of N column of origin.
          (define (insert-origin pos)
            (insert pos (list-ref origin pos)))
          )
    (build-list n insert-origin)))


; Number [Number -> Number]-> [List-of Number]
; tabulates a given func between n and 0 (incl.) in a list.

(check-expect (tabulate 10 add1) '(11 10 9 8 7 6 5 4 3 2 1))
(check-expect (tabulate 5 sqr) '(25 16 9 4 1 0))

(define (tabulate n func)
  (reverse (build-list (add1 n) func)))

