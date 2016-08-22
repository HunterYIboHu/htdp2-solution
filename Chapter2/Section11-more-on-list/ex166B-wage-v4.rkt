;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex166B-wage-v4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct employee [name code])
; Employee is a structure (make-employee String Number)
; (make-employee n c) combines the name (n) and the working code of
; the employee.

(define M-E (make-employee "Matthew" 1))
(define R-E (make-employee "Robby" 2))
(define S-E (make-employee "Snabi" 3))


(define-struct work [employee rate hours])
; Work is a structure (make-work Employee Number Number)
; (make-work n r h c) combines the employee, the pay rate (r) and
; the hours (h) worked this week.

(define MATTHEW (make-work M-E 12.95 45))
(define ROBBY (make-work R-E 11.95 39))
(define SNABI (make-work S-E 13 40))


; Low (list of works) is one of:
; - '()
; - (cons Work Low)
; interpretation an instance of Low represents the information of
; workers worked this week.

(define ONE (cons MATTHEW '()))
(define THREE (cons MATTHEW (cons ROBBY (cons SNABI '()))))


(define-struct payment [employee pay])
; Payment is a structure (make-payment Employee Number)
; (make-payment e p) combines the employee (e) self and the weekly pay (p).


; Lop (list of payment) is one of:
; - '()
; - (cons Payment Lop)
; interpretation an instance of Lop represents the information of
; workers worked this week.


;; main functions
; Low -> Lop
; computes the given list an-lop and produce the result of payment
; these employee shall get.

(check-expect (wage*.v4 '()) '())
(check-expect (wage*.v4 ONE) (cons (for-work.v3 MATTHEW) '()))
(check-expect (wage*.v4 THREE) (cons (for-work.v3 MATTHEW)
                                     (cons (for-work.v3 ROBBY)
                                           (cons (for-work.v3 SNABI)
                                                 '()))))

(define (wage*.v4 an-low)
  (cond [(empty? an-low) '()]
        [(cons? an-low)
         (cons (for-work.v3 (first an-low)) (wage*.v4 (rest an-low)))]))


;; auxilliary functoins
; Work -> Payment
; computes the given Work and produce the specific payment of the employee.

(check-expect (for-work.v3 MATTHEW) (make-payment M-E (* 12.95 45)))
(check-expect (for-work.v3 SNABI) (make-payment S-E (* 13 40)))

(define (for-work.v3 w)
  (make-payment (work-employee w) (* (work-rate w) (work-hours w))))




