;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 23.3-list-pick) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; N is one of: 
; – 0
; – (add1 N)


;; functions
; [List-of Symbol] N -> Symbol
; extracts the nth symbol from l; 
; signals an error if there is no such symbol


(check-error (list-pick '() 0) "list too short")
(check-expect (list-pick (cons 'a '()) 0) 'a)
(check-error (list-pick '() 3) "list too short")
(check-error (list-pick (cons 'a '()) 3) "list too short")

(define (list-pick l n)
  (cond [(and (= n 0) (empty? l)) (error "list too short")]
        [(and (> n 0) (empty? l)) (error "list too short")]
        [(and (= n 0) (cons? l)) (first l)]
        [(and (> n 0) (cons? l)) (list-pick (rest l) (sub1 n))]))