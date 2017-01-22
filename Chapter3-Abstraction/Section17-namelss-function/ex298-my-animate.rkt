;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex298-my-animate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


(define (create-UFO-scene height)
  (underlay/xy (rectangle 100 100 "solid" "white") 50 height UFO))
 
(define UFO
  (underlay/align "center"
                  "center"
                  (circle 10 "solid" "green")
                  (rectangle 40 4 "solid" "green")))
 
;(animate create-UFO-scene)


; An ImageStream is a function:
;    [N -> Image]
; interpretation a stream s denotes a series of images.

; ImageStream Number -> Number
; WorldState: current y-coordinate of the image.
(define (my-animate stream height)
  (big-bang 0
            [on-tick add1 1/30]
            [to-draw stream]
            [stop-when (lambda (h) (= (+ h (image-height UFO)) height))]))


;; launch program
(my-animate create-UFO-scene 100)