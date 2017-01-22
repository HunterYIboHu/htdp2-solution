;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname wage-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] [List-of Number] -> [List-of Number]
; multiplies the corresponding items on hours and wages/h
; assume the two lists are of equal length.

(check-expect (wage*.v2 '() '()) '())
(check-expect (wage*.v2 '(5.65) '(40)) '(226.0))
(check-expect (wage*.v2 '(5.65 8.75) '(40.0 30.0)) '(226.0 262.5))

(define (wage*.v2 hours wages/h)
  (cond [(empty? hours) '()]
        [else (cons (weekly-wage (first hours)
                                 (first wages/h))
                    (wage*.v2 (rest hours) (rest wages/h)))]))


; Number Number -> Number
; computes the weekly wage from pay-rate and hours

(check-expect (weekly-wage 0 10) 0)
(check-expect (weekly-wage 10.5 24) 252)
(check-expect (weekly-wage 5.65 40.0) 226.0)

(define (weekly-wage pay-rate hours)
  (* pay-rate hours))


;; Questions
;; Q1: Which function do you need to use if you wish to compute the wages for one
;; worker?
;; A1: Function named weekly-wage.
;;
;; Q2: Which function do you need to change if you wish to deal with income taxes?
;; A2: Function named weekly-wage.