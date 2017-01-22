;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex427-quick-sort-V3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; functions
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon.

(check-expect (quick-sort<.v3 '(1 6 2 99 4 23))
              '(1 2 4 6 23 99))
(check-expect (quick-sort<.v3 '(10 40 30 20))
              '(10 20 30 40))
(check-expect (quick-sort<.v3 '()) '())
(check-expect
 (quick-sort<.v3 '(84 55 65 31 61 40 19 66 74 63 13 49 26 44 43 27 34
                      21 88 96 11 42 32 24 81 53 12 39 41 99 28 38 17
                      8 79 2 54 47 10 85 92 80 37 36 5 29 14 94 22 89
                      0 97 60 70 20 15 64 98))
 '(0 2 5 8 10 11 12 13 14 15 17 19 20 21 22 24 26 27 28 29 31 32 34 36
     37 38 39 40 41 42 43 44 47 49 53 54 55 60 61 63 64 65 66 70 74 79
     80 81 84 85 88 89 92 94 96 97 98 99))

(define (quick-sort<.v3 alon)
  (local ((define threshold 10))
    (cond [(empty? alon) '()]
          [(>= 10 (length alon)) (sort< alon)]
          [else (local ((define pivot (first alon)))
                  (append (quick-sort<.v3 (smallers alon pivot))
                          (list pivot)
                          (quick-sort<.v3 (largers alon pivot))))])))


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


;; auxiliary functions
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon.

(check-expect (sort< '(11 8 14 7))
              '(7 8 11 14))
(check-expect (sort< '(11 5 3 4 56))
              '(3 4 5 11 56))
(check-expect (sort< '()) '())

(define (sort< alon)
  (cond [(empty? alon) '()]
        [(empty? (rest alon)) `(,(first alon))]
        [else (insert (first alon)
                      (sort< (rest alon)))]))


; Number [List-of Number] -> [List-of Number]
; insert n into the proper position of sorted.

(check-expect (insert 11 '(7 8 14))
              '(7 8 11 14))
(check-expect (insert 11 '()) '(11))
(check-expect (insert 12 '(17 23 45))
              '(12 17 23 45))

(define (insert n sorted)
  (cond [(empty? sorted) `(,n)]
        [else (local ((define head (first sorted)))
                (if (< n head)
                    (cons n sorted)
                    (cons head (insert n (rest sorted)))))]))

