;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex369-find-attr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An Xexpr.v2 is a list: 
; – (cons Symbol XL)
; if there is onely one empty list, the list means the missing of attributes.

; An XL is one of:
; – [List-of Xexpr.v2]
; – (cons [List-of Attribute] [List-of Xexpr.v2])
; 
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))


;; constants
(define a0 '((initial "X")))
(define a1 '((initial "X") (exact "true") (support-1.1 "true")))
(define a2 '((exact "true") (racket-version "6.5[3m]")))


;; functions
; [List-of Attribute] Symbol -> [Maybe String]
; produces the pair which starts with the given attr in the la;
; #false otherwise.

(check-expect (find-attr a0 'initial) '(initial "X"))
(check-expect (find-attr a1 'support-1.1) '(support-1.1 "true"))
(check-expect (find-attr a2 'initial) #false)

(define (find-attr al attr)
  (assq attr al))








