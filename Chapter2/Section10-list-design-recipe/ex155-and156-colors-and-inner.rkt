;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex155-and156-colors-and-inner) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


(define-struct layer [color doll])


; An RD(russian doll) is one of:
; - String
; - (make-layer String RD)
; examples:

(define THREE (make-layer "yellow" (make-layer "green" "red")))


; RD -> Number
; how many dolls are part of an-rd

(check-expect (depth THREE) 3)
(check-expect (depth "red") 1)

(define (depth an-rd)
  (cond [(string? an-rd) 1]
        [(layer? an-rd) (add1 (depth (layer-doll an-rd)))]))


; RD -> String
; consumes a RD and produces a string of all colors,
; separate by a comma and a space.

(check-expect (colors THREE) "yellow, green, red")
(check-expect (colors "red") "red")

(define (colors an-rd)
  (cond [(string? an-rd) an-rd]
        [(layer? an-rd) (string-append (layer-color an-rd) ", "
                                       (colors (layer-doll an-rd)))]))


; RD -> String
; get the color of the innermost doll

(check-expect (inner THREE) "red")
(check-expect (inner "green") "green")

(define (inner an-rd)
  (cond [(string? an-rd) an-rd]
        [(layer? an-rd) (inner (layer-doll an-rd))]))


; (inner THREE)
; use stepper to evaluate it.





