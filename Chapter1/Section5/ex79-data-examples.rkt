;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex79-data-examples) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Color is one of:
; - "white"
; - "yellow"
; - "orange"
; - "green"
; - "red"
; - "blue"
; - "black"
(define color-1 "white")
(define color-2 "red")


; H (a "happiness scale value") is a number in [0, 100],
; i.e., a number between 0 and 100
(define H-1 100)
(define H-2 45)


; Person is (make-person String String Boolean)
(define-struct person [fstname lstnae male?])

; examples:
(define Tate (make-person "Bruce" "Tate" #t))
(define Mary (make-person "Kerl" "Mary" #f))


; Weapon is one of:
; - #false
; - Posn
; interpretation #f means the missile hasn't been fired yet;
; and instance of Posn means the missile is in flight
(define-struct weapon [posn])

(define weapon-1 (make-weapon #f))
(define weapon-2 (make-weapon (make-posn 3 4)))
