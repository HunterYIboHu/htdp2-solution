;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex94-define-constants) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physical constants
(define WORLD-WIDTH 200)
(define WORLD-HEIGHT (* 3/4 WORLD-WIDTH))

(define TANK-SPEED 5)
(define UFO-SPEED 8)
(define MISSLE-SPEED (* 2 UFO-SPEED))

; graphical constants
(define BKG (empty-scene WORLD-WIDTH WORLD-HEIGHT))
(define UFO
  (underlay (rectangle 40 10 "solid" "orange")
            (ellipse 15 15 "solid" "red")))
(define TANK (rectangle 20 8 "solid" "green"))
(define MISSLE
  (rotate 180 (polygon (list (make-posn 0 0)
                             (make-posn 5 5)
                             (make-posn 10 0)
                             (make-posn 5 10))
                       "solid"
                       "blue")))


