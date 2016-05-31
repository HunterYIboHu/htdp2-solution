;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex59-racket-launch) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physical constants
(define HEIGHT 300)
(define WIDTH (/ HEIGHT 3))
(define YDELTA 3)

; graphical constants
(define BACKG (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))
(define X-ROCKET 10)


; A LRCD (short for: launching rocket count down) is one of:
; - "resting"
; - a number in [-3, -1]
; - a non-negative number
; interpretation a rocket resting on the ground, in count-down
; mode, or the number of pixels between the ground and the
; ROCKET-CENTER i.e. its height


; LRCD -> Image
; render the LRCD to Image, it consumes a LRCD, and return a image.
; examples:

(check-expect (show "resting")
              (place-image ROCKET
                           X-ROCKET (- HEIGHT ROCKET-CENTER)
                           BACKG))
(check-expect (show -3)
              (place-image (text "-3" 20 "red")
                           X-ROCKET (* 3/4 WIDTH)
                           (place-image ROCKET
                                        X-ROCKET
                                        (- HEIGHT
                                           ROCKET-CENTER)
                                        BACKG)))
(check-expect (show 53)
              (place-image ROCKET
                           X-ROCKET
                           (- 53 ROCKET-CENTER)
                           BACKG))

(define (show x)
  ...)


































































