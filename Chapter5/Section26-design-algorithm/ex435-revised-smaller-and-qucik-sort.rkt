;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex435-revised-smaller-and-qucik-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct 

(check-expect (quick-sort< '(1 7 4 0)) '(0 1 4 7))
(check-expect (quick-sort< '()) '())
(check-expect (quick-sort< '(1 1 2 4 5 4))
              '(1 1 2 4 4 5))

(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers (rest alon) pivot))
                    (list pivot)
                    (quick-sort< (largers alon pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))

; [List-of Number] Number -> [List-of Number]
(define (smallers l n)
  (cond
    [(empty? l) '()]
    [else (if (<= (first l) n)
              (cons (first l) (smallers (rest l) n))
              (smallers (rest l) n))]))