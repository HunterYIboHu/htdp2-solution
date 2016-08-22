;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex186-reform-test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)
; interpretation a brunch of numbers


;; main functions
; List-of-numbers -> List-of-numbers
; rearrangle alon in descending order

(check-satisfied (sort> '()) sorted>?)
(check-satisfied (sort> (list 12 20 -5)) sorted>?)
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)

(define (sort> alon)
  (cond [(empty? alon) '()]
        [else (insert (first alon) (sort> (rest alon)))]))


;; functions need test
; List-of-numbers -> List-of-numbers
; produces a sorted version of l

; (check-expect (sort>/bad (list 3 4 0)) (list 4 3 0))
(check-satisfied (sort>/bad (list 3 4 0)) sorted>?)
; the result of test is wrong.

(define (sort>/bad l)
  '(9 8 7 6 5 4 3 2 1 0))


;; auxiliary functions
; Number List-of-numbers -> List-of-numbers
; insert n into the sorted list of numbers alon

(check-satisfied (insert 5 '()) sorted>?)
(check-satisfied (insert 5 (list 6)) sorted>?)
(check-satisfied (insert 5 (list 4)) sorted>?)
(check-satisfied (insert 12 (list 20 -5)) sorted>?)
(check-satisfied (insert -10 (list 20 -5)) sorted>?)
(check-satisfied (insert 30 (list 20 -5)) sorted>?)

(define (insert n alon)
  (cond [(empty? alon) (cons n '())]
        [else (if (>= n (first alon))
                  (cons n alon)
                  (cons (first alon) (insert n (rest alon))))]))


; List-of-numbers -> Boolean
; determine weather the numbers are sorted in descending order,
; on this case, it produce #true; otherwise it produce #false.

(check-expect (sorted>? (list 12 10 8)) #true)
(check-expect (sorted>? (list 12 10 39)) #false)
(check-expect (sorted>? (list 12)) #true)
(check-expect (sorted>? '()) #true)

(define (sorted>? alon)
  (cond [(empty? alon) #t]
        [(empty? (rest alon)) #t]
        [else (and (>= (first alon) (second alon))
                   (sorted>? (rest alon)))]))


;; Questions
;; Q1: Can you formulate a test case that shows sort>/bad is not
;; a sorting function?
;; A1: Can, and the expr is the following content:
;; (check-expect (sort>/bad (list 3 4 0)) (list 4 3 0))
;;
;; Q2: Can you use check-satisfied to formulate this test case?
;; A2: No, but for now.