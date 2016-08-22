;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex161-wage-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '()))
              (cons (wage 28) '()))
(check-expect (wage* (cons 40 (cons 28 '())))
              (cons (wage 40) (cons (wage 28) '())))

(define (wage* alon)
  (cond [(empty? alon) '()]
        [else (cons (wage (first alon)) (wage* (rest alon)))]))
