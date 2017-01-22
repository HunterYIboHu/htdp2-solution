;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex395-take-and-drop) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; N is one of: 
; – 0
; – (add1 N)


;; constants
(define l1 '(1 2 3))
(define l2 '(1 2 3 4 5))


;; functions
; N [List-of Number] -> [List-of Number]
; produces the first n items from l or all of l is l is too short.

(check-expect (take 0 '()) '())
(check-expect (take 0 l1) '())
(check-expect (take 3 '()) '())
(check-expect (take 3 l2) '(1 2 3))
(check-expect (take 6 l2) l2)

(define (take n l)
  (cond [(and (> n 0) (cons? l))
         (cons (first l) (take (sub1 n) (rest l)))]
        [else '()]))


; N [List-of Number] -> [List-of Number]
; produces a list with the first n items removed or just '() if l is too short.

(check-expect (drop 0 '()) '())
(check-expect (drop 0 l1) l1)
(check-expect (drop 3 l2) '(4 5))
(check-expect (drop 3 l1) '())

(define (drop n l)
  (cond [(= n 0) l]
        [(empty? l) '()]
        [else (drop (sub1 n) (rest l))]))

