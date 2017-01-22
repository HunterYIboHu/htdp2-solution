;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex288-build-list-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
  (build-list num (lambda (x) (/ 1 (expt 10 x)))))


; N -> [List-of N]
; produces the list of the first n even numbers.

(check-expect (even-list 4) '(0 2 4 6))
(check-expect (even-list 8) '(0 2 4 6 8 10 12 14))

(define (even-list n)
  (build-list n (lambda (x) (* 2 x))))


; N -> [List-of [List-of N]]
; create a diagonal square of 0s and 1s

(check-expect (identityM 1) `(,'(1)))
(check-expect (identityM 3) '((1 0 0) (0 1 0) (0 0 1)))
(check-expect (identityM 5)
              '((1 0 0 0 0) (0 1 0 0 0) (0 0 1 0 0) (0 0 0 1 0) (0 0 0 0 1)))

(define (identityM n)
  (build-list n (lambda (pos)
                  (build-list n (lambda (current)
                                  (if (= pos current) 1 0))))))












