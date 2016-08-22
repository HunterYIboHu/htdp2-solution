;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex176-matrix) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; A Matrix is one of:
; - (cons Row '())
; - (cons Row Martix)
; constraint all rows in matrix are of the same length

; An Row is one of:
; - '()
; - (cons Number Row)

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define row3 (cons 31 (cons 32 '())))

(define mat1 (cons row1 (cons row2 '())))
(define mat2 (cons row1 (cons row2 (cons row3 '()))))


;; main functions
; Matrix -> Matrix
; transpose the items on the given matrix along the diagonal

(define trans-row1 (cons 11 (cons 21 '())))
(define trans-row2 (cons 12 (cons 22 '())))
(define trans-mat1 (cons trans-row1 (cons trans-row2 '())))

(define trans-row1-B (cons 11 (cons 21 (cons 31 '()))))
(define trans-row2-B (cons 12 (cons 22 (cons 32 '()))))
(define trans-mat2 (cons trans-row1-B (cons trans-row2-B '())))

(check-expect (transpose mat1) trans-mat1)
(check-expect (transpose mat2) trans-mat2)

(define (transpose lln)
  (cond [(empty? (first lln)) '()]
        [else (cons (first* lln) (transpose (rest* lln)))]))


;; auxilliary functions
; Matrix -> List-of-numbers
; consume a matrix and produce the first column as a list of numbers.

(check-expect (first* mat1) trans-row1)
(check-expect (first* mat2) trans-row1-B)

(define (first* lln)
  (cond [(empty? lln) '()]
        [else (cons (first (first lln))
                    (first* (rest lln)))]))


; Matrix -> Matrix
; consume a matrix and produce a matrix which remove the first column.

(check-expect (rest* mat1) (cons (cons 12 '())
                                 (cons (cons 22 '())
                                       '())))
(check-expect (rest* mat2) (cons (cons 12 '())
                                 (cons (cons 22 '())
                                       (cons (cons 32 '())
                                             '()))))

(define (rest* lln)
  (cond [(empty? lln) '()]
        [else (cons (rest (first lln))
                    (rest* (rest lln)))]))


;; Questions
;; Q1: Why does transpose ask (empty? (first lln))?
;; A1: Because the given Matrix always have items -- the lists. But the lists
;; will be empty when you extract the Number it contains, and that's the time
;; to stop computing.
;;
;; Q2: You should also understand that you cannot design this function with
;;     the design recipes you have seen so far. Explain why.
;; A2: Because the design recipes don't care about how to deal with nest list
;; that need to process the items -- a list too -- in one functions.

