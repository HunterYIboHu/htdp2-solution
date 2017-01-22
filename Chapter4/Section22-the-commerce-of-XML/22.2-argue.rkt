;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 22.2-argue) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An XEnum.v1 is one of: 
; – (cons 'ul [List-of XItem.v1])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v1]))
; An XItem.v1 is one of:
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
;
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))
;
; An XWord is '(word ((text String)))


; An Xexpr.v2 is a list: 
; – (cons Symbol XL)
; if there is onely one empty list, the list means the missing of attributes.

; An XL is one of:
; – [List-of Xexpr.v2]
; – (cons [List-of Attribute] [List-of Xexpr.v2])


;; Question
;; Q1: Argue that every element of XEnum.v1 is also in XExpr.
;; A1: An XEnum.v1 is (cons Symbol Other), and the Other's style likes XL.
;; The difference between them is XItem.v1 and Xexpr.v2. But and XItem.v1 is
;; the difference between XL and the rest field of XItem.v1.(cons XWord '()) like
;; XL, the key is: whether XWord is in Xexpr.v2. The answer is yes.The XWord is a
;; Xexpr.v2 whose name is 'word, whose attribute is 'text and the value is String.

