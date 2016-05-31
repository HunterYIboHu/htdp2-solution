;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex68-other-way) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; balld
; represent the ball state using location and direction.
; the location is Number, represent the y-coordinate of ball
; the direction is String, represent how SPEED add to location

; physics constant
(define SPEED 3)

(define-struct balld [location direction])
(define bl1
  (make-balld 10 "down"))
