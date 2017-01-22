;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex311-average-age) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; Pyhsical constants
(define CURRENT 2016)


;; functions
; FT -> Number
; counts the child structures in a-ftree.

(check-expect (count-persons Carl) 1)
(check-expect (count-persons Eva) 3)
(check-expect (count-persons Gustav) 5)

(define (count-persons a-ftree)
  (match a-ftree
    [(? no-parent?) 0]
    [(child fa mo n d e) (+ (count-persons fa)
                            (count-persons mo)
                            1)]))


; FT Number -> Number
; produces the average age of all child in a-ftree, assuming that
; they all alive now.

(check-expect (average-age Carl CURRENT) 90)
(check-expect (average-age Eva CURRENT) 77)
(check-expect (average-age Gustav CURRENT) 61.8)

(define (average-age a-ftree current)
  (cond [(no-parent? a-ftree) 0]
        [else (/ (sum-age a-ftree current)
                 (count-persons a-ftree))]))


;; auxiliary functions
; FT Number -> Number
; produces the total age of all child in a-ftree, assuming that
; they all alive now.

(check-expect (sum-age Carl CURRENT) 90)
(check-expect (sum-age Eva CURRENT) 231)
(check-expect (sum-age Gustav CURRENT) 309)

(define (sum-age a-ftree current)
  (match a-ftree
    [(? no-parent?) 0]
    [(child fa mo n d e) (+ (sum-age fa current)
                            (sum-age mo current)
                            (- current d))]))

