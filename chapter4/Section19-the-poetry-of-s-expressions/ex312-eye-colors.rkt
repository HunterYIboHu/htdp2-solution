;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex312-eye-colors) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


;; data difinitions
(define-struct no-parent [])
(define NP (make-no-parent))
(define-struct child [father mother name date eyes])
; A FT (short for family tree) is one of: 
; – NP
; – (make-child FT FT String N String)


;; constants
; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))


;; functions
; FT -> [List-of String]
; produces a list of all eye colors in the tree, an eye color may occur more than
; once.

(check-expect (eye-colors Carl) '("green"))
(check-expect (eye-colors Adam) '("green" "green" "hazel"))
(check-expect (eye-colors Gustav) '("pink" "green" "green" "blue" "brown"))

(define (eye-colors a-ftree)
  (match a-ftree
    [(? no-parent?) '()]
    [(child fa mo n d e) `(,@(eye-colors fa)
                           ,@(eye-colors mo)
                           ,e)]))

