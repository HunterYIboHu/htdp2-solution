;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex370-word-predicate-and-text) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;
; An XWord is '(word ((text String)))


;; constants
(define word-1 '(word ((text "libary"))))
(define word-2 '(word ((text "racket"))))
(define word-3 '(word ((text "parser"))))


;; functions
; X -> Boolean
; determine whether the input is XWord.

(check-expect (word? "string") #f)
(check-expect (word? '(word ((text #true)))) #f)
(check-expect (word? #true) #f)
(check-expect (word? (make-posn 10 20)) #f)
(check-expect (word? word-1) #t)
(check-expect (word? word-2) #t)

(define (word? x)
  (if (and (cons? x)
           (not (empty? (rest x)))
           (not (empty? (second x)))
           (not (empty? (first (second x)))))
      (local ((define pair (first (second x))))
        (and (symbol=? (first x) 'word)
             (symbol=? (first pair) 'text)
             (not (empty? (rest pair)))
             (string? (second pair))))
      #false))


; XWord -> String
; produces the content of the given w.

(check-expect (word-text word-1) "libary")
(check-expect (word-text word-2) "racket")
(check-expect (word-text word-3) "parser")

(define (word-text w)
  (second (first (second w))))