;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 2.3-unqote) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; main functions
; List-of-numbers List-of-numbers -> ... nested list ...
; creates an HTML table from two lists of numbers

(check-expect (make-table '(1 2) '(3 4 10))
              '(table ((border "1"))
                      (tr (td "1") (td "2"))
                      (tr (td "3") (td "4") (td "10"))))

(define (make-table row1 row2)
  `(table ((border "1"))
          (tr ,@(make-row row1))
          (tr ,@(make-row row2))))


;; auxiliary functions
; List-of-numbers -> ... nested list ...
; creates a row for an HTML table from L

(check-expect (make-row '(1 2)) '((td "1") (td "2")))
(check-expect (make-row '(3 5 10)) '((td "3") (td "5") (td "10")))
(check-expect (make-row '()) '())

(define (make-row l)
  (cond [(empty? l) '()]
        [else (cons (make-cell (car l))
                    (make-row (cdr l)))]))


; Number -> ... nested list ...
; creates a cell for an HTML table from a number

(check-expect (make-cell 1) '(td "1"))
(check-expect (make-cell 10) '(td "10"))
(check-expect (make-cell -10) '(td "-10"))

(define (make-cell n)
  `(td ,(number->string n)))