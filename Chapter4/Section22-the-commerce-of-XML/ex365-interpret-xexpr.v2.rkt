;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex365-interpret-xexpr.v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An Xexpr.v2 is a list: 
; – (cons Symbol XL)
; An XL is one of:
; – [List-of Xexpr.v2]
; – (cons [List-of Attribute] [List-of Xexpr.v2])
; 
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))


;; constants
(define xml-1 "<server name=\"example.org\"></server>")
(define xml-2 (string-append "<carcas><board><grass></grass></board>"
                             "<player name=\"sam\"></player>/carcas>"))
(define xml-3 "<start></start>")


;; Questions
;; Q1: Which ones are elements of Xexpr.v0 or Xexpr.v1?
;; A1: xml-2 is element of Xexpr.v1;
;; xml-3 is element of Xexpr.v0.