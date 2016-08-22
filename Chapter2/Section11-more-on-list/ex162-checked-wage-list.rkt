;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex162-checked-wage-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; physical constants
(define H-WAGE 14)


; A List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)


; Number -> Number
; computes the wage for h hours of work

(check-expect (wage 10) (* H-WAGE 10))
(check-expect (wage 4) (* H-WAGE 4))

(define (wage h)
  (* H-WAGE h))


; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours

(check-expect (checked-wage* '()) '())
(check-expect (checked-wage* (cons 28 '()))
              (cons (wage 28) '()))
(check-expect (checked-wage* (cons 40 (cons 28 '())))
              (cons (wage 40) (cons (wage 28) '())))
(check-error (checked-wage* (cons 10 (cons 101 '()))))
(check-error (checked-wage* (cons 101 (cons 10 '()))))

(define (checked-wage* alon)
  (cond [(empty? alon) '()]
        [(and (cons? alon) (<= (first alon) 100))
         (cons (wage (first alon)) (checked-wage* (rest alon)))]
        [else (error
               "UnexpectNumber: the work hour should not more than 100")]))

