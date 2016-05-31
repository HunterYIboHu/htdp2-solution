;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex53-big-bang-traffic-light) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define WIDTH-OF-WORLD 200)
(define MID-WIDTH-OF-WORLD (/ WIDTH-OF-WORLD 2))
(define HEIGHT-OF-WORLD (* 3/4 200))
(define BACKGROUND
  (empty-scene WIDTH-OF-WORLD
               HEIGHT-OF-WORLD))

(define LAMP-POST
  (rectangle (/ WIDTH-OF-WORLD 20)
             (/ WIDTH-OF-WORLD 5)
             "solid" "black"))

(define LAMP-RADIUS (/ (image-width LAMP-POST) 2))
(define Y-LAMP (- HEIGHT-OF-WORLD (+ (* 2 LAMP-RADIUS)
                                     (/ WIDTH-OF-WORLD 5))))

; A TrafficLight shows one of three colors:
; - "red"
; - "green"
; - "yellow"
; interpretatino each element of TrafficLight represents which
; colored bulb is currently turned on.


; TrafficLight -> TrafficLight
; determines the next state of the traffic light from the given s

(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))


; render
; TrafficLight -> Image
; Create a image of TrafficLight, then place it in the background.
(define (render color)
  (place-image (overlay/xy (circle LAMP-RADIUS "solid" color)
                           0 (* 2 LAMP-RADIUS)
                           LAMP-POST)
               MID-WIDTH-OF-WORLD
               Y-LAMP
               BACKGROUND
               ))


; time-handler
; TrafficLight -> TrafficLight
; then change color.
(define (tock color)
  (traffic-light-next color))


; launch
; consume a String then change it.
(define (traffic-on color)
  (big-bang color
            [on-tick tock]
            [to-draw render]))

(traffic-on "red")

(= (string-length s) 1)