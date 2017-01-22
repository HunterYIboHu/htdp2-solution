;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex442-compart-sort-and-quick-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; check functions
(define check-sort
  (lambda (l) (equal? l (sort l <))))
(define check-list `(,@(make-list 10 10) 11 ,@(make-list 10 12) 13 13 ,@(make-list 5 9)))


;; functions
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon.

(check-expect (quick-sort<.v6 '(1 6 2 99 4 23))
              '(1 2 4 6 23 99))
(check-expect (quick-sort<.v6 '(10 40 30 20))
              '(10 20 30 40))
(check-expect (quick-sort<.v6 '()) '())
(check-expect
 (quick-sort<.v6 '(84 55 65 31 61 40 19 66 74 63 13 49 26 44 43 27 34
                      21 88 96 11 42 32 24 81 53 12 39 41 99 28 38 17
                      8 79 2 54 47 10 85 92 80 37 36 5 29 14 94 22 89
                      0 97 60 70 20 15 64 98))
 '(0 2 5 8 10 11 12 13 14 15 17 19 20 21 22 24 26 27 28 29 31 32 34 36
     37 38 39 40 41 42 43 44 47 49 53 54 55 60 61 63 64 65 66 70 74 79
     80 81 84 85 88 89 92 94 96 97 98 99))
(check-satisfied (quick-sort<.v6 check-list) check-sort)


(define (quick-sort<.v6 alon)
  (cond [(empty? alon) '()]
        [(empty? (rest alon)) `(,(first alon))]
        [else (local ((define pivot (first alon))
                      ; [List-of Number] -> [List-of Number]
                      ; produces the numbers in the alon which is smaller than the given
                      ; pivot.
                      (define (smallers.v2 alon)
                        (filter (lambda (num) (< num pivot)) alon))
                      ; [List-of Number] -> [List-of Number]
                      ; produces the numbers in the alon which is larger than the given
                      ; pivot.
                      (define (largers.v2 alon)
                        (filter (lambda (num) (>= num pivot)) alon)))
                (append (quick-sort<.v6 (smallers.v2 alon))
                        (list pivot)
                        (quick-sort<.v6 (largers.v2 (rest alon)))))]))


; [List-of Number] -> [List-of Number]
; produces a sorted version of alon.

(check-expect (sort< '(1 3 9 2 5)) '(1 2 3 5 9))
(check-expect (sort< '(10)) '(10))
(check-expect (sort< '()) '())

(define (sort< alon)
  (cond [(empty? alon) '()]
        [(empty? (rest alon)) `(,(first alon))]
        [else (insert (first alon)
                      (sort< (rest alon)))]))


; Number [List-of Number] -> [List-of Number]
; insert n into the proper position of sorted.

(check-expect (insert 5 '()) '(5))
(check-expect (insert 5 '(6 7 9)) '(5 6 7 9))
(check-expect (insert 5 '(1 3 4)) '(1 3 4 5))
(check-expect (insert 4 '(1 3 7 10)) '(1 3 4 7 10))

(define (insert n sorted)
  (cond [(empty? sorted) `(,n)]
        [else (local ((define head (first sorted)))
                (if (< n head)
                    (cons n sorted)
                    (cons head (insert n (rest sorted)))))]))


;; auxiliary functions
; N -> [List-of N]
; create large test case for sort functions.

(define (create-test length)
  (local ((define test-list (map (lambda (item) (random length))
                                 (make-list length 1))))
    `(,(time (sort< test-list))
      ,(time (quick-sort<.v6 test-list)))))


;; test
(map (lambda (n) (create-test n))
     '(1 5 5 7 8 10 20 50 100 1000))


;; result
;;cpu time: 0 real time: 1 gc time: 0
;;cpu time: 0 real time: 1 gc time: 0
;;cpu time: 0 real time: 9 gc time: 0
;;cpu time: 0 real time: 3 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 0 gc time: 0
;;cpu time: 0 real time: 2 gc time: 0
;;cpu time: 0 real time: 1 gc time: 0
;;cpu time: 0 real time: 7 gc time: 0
;;cpu time: 16 real time: 2 gc time: 0
;;cpu time: 828 real time: 860 gc time: 171
;;cpu time: 16 real time: 14 gc time: 0
;;
;; do not show quick-sort's performance is lower than sort when the
;; list is short.But it shows the quick-sort works better when the
;; list is large.









