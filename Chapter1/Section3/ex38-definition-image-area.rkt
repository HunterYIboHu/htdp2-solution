;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname definition-image-area) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Image -> Number
; given: (rectangle 10 20 "solid" "black"), expect: 200
; given: (circle 5 "outline", "red"), expect: 100
; counts the number of pixels in the given image img.
(define (image-area img)
  (* (image-width img)
     (image-height img)))