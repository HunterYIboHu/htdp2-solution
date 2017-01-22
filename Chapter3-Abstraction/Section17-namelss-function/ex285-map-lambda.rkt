;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex285-map-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define EURUSD 1.22)


; [List-of Number] -> [List-of Number]
; convert a list of US$ into a list of EURO €, on an exchange rate of €1.22
; per US$.

(check-expect (convert-euro '(10 20 30)) '(12.2 24.4 36.6))
(check-expect (convert-euro '(5 10 15)) '(6.1 12.2 18.3))

(define (convert-euro l)
  (map (lambda (us) (* EURUSD us)) l))


; [List-of Number] -> [List-of Number]
; convert a list of Fahrenheit measurements to a list of Celsius measurements

(check-expect (convertFC '(50 68)) '(10 20))
(check-expect (convertFC '(32 68)) '(0 20))

(define (convertFC l)
  (map (lambda (f) (/ (- f 32) 1.8)) l))


; [List-of Posn] -> [List-of [List-of Number]]
; translate a list of Posns into a list of list of pairs of numbers.

(check-expect (translate `(,(make-posn 10 25) ,(make-posn 12 24)))
              '((10 25) (12 24)))
(check-expect (translate `(,(make-posn 5 32) ,(make-posn -6 0)))
              '((5 32) (-6 0)))

(define (translate l)
  (map (lambda (p) `(,(posn-x p) ,(posn-y p))) l))