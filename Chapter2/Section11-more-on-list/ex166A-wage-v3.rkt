;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11.2-under-going) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct work [employee rate hours])
; Work is a structure (make-work String Number Number)
; interpretation (make-work n r h) combines the name (n)
; with the pay rate (r) and the number of hours (h) worked.

(define ROBBY (make-work "Robby" 11.95 39))
(define MATTHEW (make-work "Matthew" 12.95 45))
(define SNABI (make-work "Snabi" 13 40))


; Low (list of works) is one of:
; - '()
; - (cons Work Low)
; interpretation an instance of Low represents the hours worked
; of a number of employees

(define ONE (cons ROBBY '()))
(define TWO (cons MATTHEW (cons ROBBY '())))
(define THREE (cons MATTHEW (cons ROBBY (cons SNABI '()))))
(define ONE-B (cons SNABI '()))


; Low -> List-of-numbers
; computes the weekly wages for all given weekly work records

(check-expect (wage*.v2 ONE) (cons (* (work-rate ROBBY)
                                      (work-hours ROBBY))
                                   '()))
(check-expect (wage*.v2 TWO) (cons (* (work-rate MATTHEW)
                                      (work-hours MATTHEW))
                                   (cons (* (work-rate ROBBY)
                                            (work-hours ROBBY))
                                         '())))
(check-expect (wage*.v2 THREE) (cons (* (work-rate MATTHEW)
                                        (work-hours MATTHEW))
                                   (cons (* (work-rate ROBBY)
                                            (work-hours ROBBY))
                                         (cons (* (work-rate SNABI)
                                                  (work-huors SNABI))
                                               '()))))

(define (wage*.v2 an-low)
  (cond [(empty? an-low) ...]
        [(cons? an-low)
         (... (for-work (first an-low)) 
          ... (wage*.v2 (rest an-low)) ...)]))


; Work -> ???
; a template for functions that process work structures
(define (for-work w)
  (... (work-employee w) ... (work-rate w) ... (work-hours w) ...))











