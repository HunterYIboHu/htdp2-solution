;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex364-represent-XML) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define xml-1 '(transition ((from "seen-e") (to "seen-f"))))
; <transition from="seen-e" to="seen-f" />

(define xml-2 '(ul (li (word)
                       (word))
                   (li (word))))
; <ul><li><word /><word /></li><li><word /></li></ul>

(define xml-3 '(end))
; <end></end>


;; Questions
;; Q1: Which one could be represented in Xexpr.v0 or Xexpr.v1?
;; A1: xml-3 could be represented in Xexpr.v0 or Xexpr.v1;
;; xml-2 could be represented in Xexpr.v1;
;; xml-3 couldn't.



