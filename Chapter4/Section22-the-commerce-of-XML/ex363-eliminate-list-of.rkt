;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex363-eliminate-list-of) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; before revising
; An Xexpr.v2 is a list: 
; – (cons Symbol XL)
; An XL is one of:
; – [List-of Xexpr.v2]
; – (cons [List-of Attribute] [List-of Xexpr.v2])
; 
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))


;; after revising
; data difinitions
; An Xexpr.v2 is a list: 
; – (cons Symbol XL)

; An XL is one of:
; - '()
; – (cons Xexpr.v2 XL)
; – (cons AL (cons Xexpr.v2 XL))
; 
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))
;
; An AL is one of:
; - '()
; - (cons Attribute AL)