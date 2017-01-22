;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex388-refine-wage.v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct employee [name ssn pay-rate])
; a Employee is (make-employee String Number Number)
;    (make-employee n s p)
; n is the name of the employee, s is the social security number, and
; p is the pay rate of the employee.


(define-struct record [name hours])
; a Record is (make-record String Number)
;    (make-record n h)
; n is the name of the record's worker, h is the hours worked this week.


;; constants
(define e1 (make-employee "John" 2621 40.0))
(define e2 (make-employee "Matthew" 2547 30.0))

(define r1 (make-record "John" 5.65))
(define r2 (make-record "Matthew" 8.75))

(define el1 `(,e1))
(define el2 `(,e1 ,e2))

(define rl1 `(,r1))
(define rl2 `(,r1 ,r2))


;; functions
; [List-of Employee] [List-of Record] -> [List-of Number]
; produces the list of weekly-wage for every employees.

(check-expect (wage*.v3 '() '()) '())
(check-expect (wage*.v3 el1 rl1) '(226))
(check-expect (wage*.v3 el2 rl2) '(226 262.5))

(define (wage*.v3 employees records)
  (cond [(empty? employees) '()]
        [else (cons (weekly-wage (first employees) records)
                    (wage*.v3 (rest employees) records))]))


;; auxiliary functions
; Employee [List-of Record] -> Number
; produces the wage of the e by finding the according work-record in lor.

(check-expect (weekly-wage e1 rl1) 226)
(check-expect (weekly-wage e1 rl2) 226)
(check-error (weekly-wage e2 rl1))

(define (weekly-wage e lor)
  (local ((define l (filter (lambda (r) (string=? (employee-name e)
                                                  (record-name r))) lor)))
    (if (empty? l)
        (error (string-append "not found specific worker's record: "
                              (employee-name e)))
        (* (employee-pay-rate e)
           (record-hours (first l))))))

