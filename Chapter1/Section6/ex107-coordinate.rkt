;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex107-coordinate) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct coordinate [pos])
; A Coordinate is one of:
; - a negative number
;    interpretation a point on the Y axis, distance from top.
; - a positive number
;    interpretation a point on the X axis, distance from left.
; - a Posn
;    interpretation a point in a scene, usual interpretation.
; examples:

(define y-coor (make-coordinate 5))
; interpretation a point on (5, 0)
(define y-coor-2 (make-coordinate 12))
; interpretation a point on (12, 0)
(define x-coor (make-coordinate -7))
; interpretation a point on (0, -7)
(define x-coor-2 (make-coordinate -20))
; interpretation a point on (0, -20)
(define coor (make-coordinate (make-posn 20 30)))
; interpretation a point on (20, 30)
(define coor-2 (make-coordinate (make-posn 13 13)))
; interpretation a point on (13, 13)
