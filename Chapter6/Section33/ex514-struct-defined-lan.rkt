;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex514-struct-defined-lan) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Lambda is one of:
; - Variable
; - Lam
; - Application

; A Variable is a Symbol.

(define-struct lam [para body])
; A Lam is (make-lam Parameter Body)
; A Parameter is one of :
; - Symbol
; - '()
; A Body is one of:
; - Variable
; - Lam

(define-struct app [fun arg])
; A Application is (make-app Lam Lam)


;; data examples
(define ex1 (make-lam 'x 'x))
(define ex2 (make-lam 'x 'y))
(define ex3 (make-lam 'y (make-lam 'x 'y)))
(define ex4 'x)

