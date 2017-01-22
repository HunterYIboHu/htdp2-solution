;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex394-merge) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define s1 '(1 2 3 6 8))
(define s2 '(2 3 8 10 12 34))
(define s3 '(9 3 1 6 4))


;; functions
; [List-of Number] [List-of Number] -> [List-of Number]
; produces a single sorted list of numbers that contains all the numbers on both
; input lists. A number occurs in the output as many times as it occurs on the two
; input lists together.

(check-expect (merge s1 s2) '(1 2 2 3 3 6 8 8 10 12 34))
(check-expect (merge s1 s3) '(1 1 2 3 3 4 6 6 8 9))
(check-expect (merge s2 s3) '(1 2 3 3 4 6 8 9 10 12 34))
(check-expect (merge s3 '()) '(1 3 4 6 9))
(check-expect (merge '() s3) '(1 3 4 6 9))
(check-expect (merge '() '()) '())

(define (merge lon-1 lon-2)
  (cond [(empty? lon-1) (foldr insert '() lon-2)]
        [(empty? lon-2) (foldr insert '() lon-1)]
        [else (insert (first lon-1)
                      (merge (rest lon-1) lon-2))]))


;; auxiliary functions
; Number [List-of Number] -> [List-of Number]
; produces a single list which the number are insert in ascending order.
; the sorted must be a sorted list, in ascending order.

(check-expect (insert 1 '()) '(1))
(check-expect (insert 1 '(-1 0 1)) '(-1 0 1 1))
(check-expect (insert 10 '(100 200 300)) '(10 100 200 300))
(check-expect (insert 10 '(5 6 7 9 11 30)) '(5 6 7 9 10 11 30))

(define (insert num sorted)
  (cond [(empty? sorted) `(,num)]
        [else
         (local ((define head (first sorted)))
           (cond [(<= num head) (cons num sorted)]
                 [else (cons head (insert num (rest sorted)))]))]))

