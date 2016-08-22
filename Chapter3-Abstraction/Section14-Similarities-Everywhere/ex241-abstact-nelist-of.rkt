;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex241-abstact-nelist-of) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; A CTemperature is a Number greater than -273.


; A NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures


; A NEList-of-numbers is one of:
; - (cons Number '())
; - (cons Numebr NEList-of-numbers)
; interpretation non-empty lists of Numbers.


; A [NEList-of ITEM] is one of:
; - (list ITEM)
; - (cons ITEM [NEList-of ITEM])
; interpretation non-empty lists of ITEMs.


; NEList-of-numbers is [NEList-of Number]

(define nelon-1 '(1 23 4))
(define nelon-2 '(0.2 2-i -1))


; NEList-of-temperatures is [NEList-of CTemperature]

(define nelot-1 '(1 2 3))
(define nelot-2 '(-200 200 254))