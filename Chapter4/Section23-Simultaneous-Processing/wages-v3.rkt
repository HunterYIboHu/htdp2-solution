;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname wages-v3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct card [number hours])
; A Card is (make-car String Number)
; a number is a numberic string represent five-digit;
; a hours is a number represent the hours worked per week.


(define-struct record [name number pay-rate])
; A Record is (make-record String String Number)
; a name represent the name of the record's employee;
; a number is a numberic string represent five-digit;
; a pay-rate represent the pay rate per hour of the employee.


;; constants
(define card-1 (make-card "50496" 40))
(define card-2 (make-card "44444" 50))

(define record-1 (make-record "LiMing" "50496" 8.5))
(define record-2 (make-record "Matthew" "44444" 6.4))


;; functions
; [List-of Card] [List-of Record] -> [List-of Number]
; produces a list of wage records, which contain the name and weekly wage of an
; employee. It will signals an error when it cannot find an employee record for
; time card or vice versa.

(check-expect (wages*.v3 '() '()) '())
(check-expect (wages*.v3 `(,card-1) `(,record-1)) '(340))
(check-expect (wages*.v3 `(,card-1 ,card-2) `(,record-2 ,record-1)) '(340 320))
(check-error (wages*.v3 `(,card-2 ,card-2) `(,record-2)))
(check-error (wages*.v3 `(,card-1) `(,record-1 ,record-2)))
(check-error (wages*.v3 `(,card-2) `(,record-1)))

(define (wages*.v3 cards records)
  (cond [(and (empty? cards) (empty? records)) '()]
        [(and (empty? cards) (cons? records))
         (error "The amount of records is larger than cards.")]
        [(and (cons? cards) (empty? records))
         (error "The amount of cards is larger than records.")]
        [else
         (local ((define the-card (first cards))
                 (define the-records
                   (filter (lambda (one-record)
                             (string=? (record-number one-record)
                                       (card-number the-card))) records))
                 (define the-record (if (empty? the-records)
                                        (error "no corresponding record of this employee.")
                                        (first the-records))))
           (cons (weekly-wage the-card the-record)
                 (wages*.v3 (rest cards) (remove the-record records))))]))


;; auxiliary functions
; Card Record -> Number
; prodcues the weekly wage according to the given c and r.

(check-expect (weekly-wage card-1 record-1) 340)
(check-expect (weekly-wage card-2 record-2) 320)

(define (weekly-wage c r)
  (* (card-hours c)
     (record-pay-rate r)))

