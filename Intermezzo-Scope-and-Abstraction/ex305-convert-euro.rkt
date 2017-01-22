;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex305-convert-euro) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


;; constants
(define EURUSD 1.22)


; [List-of Number] -> [List-of Number]
; convert a list of US$ into a list of EURO €, on an exchange rate of €1.22
; per US$.

(check-expect (convert-euro '(10 20 30)) '(12.2 24.4 36.6))
(check-expect (convert-euro '(5 10 15)) '(6.1 12.2 18.3))

(define (convert-euro l)
  (for/list ([us l])
    (* EURUSD us)))