;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 25.2-quick-sort-assending) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon.

(check-expect (quick-sort< '(1 6 2 99 4 23))
              '(1 2 4 6 23 99))
(check-expect (quick-sort< '(10 40 30 20))
              '(10 20 30 40))
(check-expect (quick-sort< '()) '())

(define (quick-sort< alon)
  (cond [(empty? alon) '()]
        [else (local ((define pivot (first alon)))
                (append (quick-sort< (smallers alon pivot))
                        (list pivot)
                        (quick-sort< (largers alon pivot))))]))


;; auxiliary functions
; [List-of Number] Number -> [List-of Number]
; produces the numbers in the alon which is smaller than the given
; pivot.

(check-expect (smallers '(1 2 5 77 3 4) 4) '(1 2 3))
(check-expect (smallers '(1 2 5 77 3 4) 0) '())
(check-expect (smallers '() 0) '())

(define (smallers alon pivot)
  (filter (lambda (num) (< num pivot)) alon))


; [List-of Number] Number -> [List-of Number]
; produces the numbers in the alon which is larger than the given
; pivot.

(check-expect (largers '(1 2 5 77 3 4) 4) '(5 77))
(check-expect (largers '(1 2 5 77 3 4) 78) '())
(check-expect (largers '() 0) '())

(define (largers alon pivot)
  (filter (lambda (num) (> num pivot)) alon))

