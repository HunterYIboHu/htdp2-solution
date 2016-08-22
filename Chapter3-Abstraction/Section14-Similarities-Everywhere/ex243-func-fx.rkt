;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex243-func-fx) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; function difinitions
(define (f x) x)


;; the result of running
; > (cons f '())
; (list f)
;;;; A: functions could be value in ISL.

; > (f f)
; f
;;;; A: function f consume f as a parameter, and according to the define, it
;;;; produces the consumed parameter, thus return function f as value.

; > (cons f (cons 10 (cons (f 10) '())))
; (list f 10 10)
;;;; A: the last item of list apply f to 10, thus return 10, and 10 become one
;;;; of the items in list.