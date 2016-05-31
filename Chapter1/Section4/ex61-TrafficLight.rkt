;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.7-TrafficLight) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physics constants
(define BKG-WIDTH 100)
(define BKG-HEIGHT 30)
(define RADIUS (* 1/3 BKG-HEIGHT))
(define MID-H (/ BKG-HEIGHT 2))


; graphic constants
(define BKG (empty-scene BKG-WIDTH BKG-HEIGHT))
(define BLUB-R (circle RADIUS "outline" "red"))
(define BLUB-Y (circle RADIUS "outline" "yellow"))
(define BLUB-G (circle RADIUS "outline" "green"))
(define TRAFFIC-LIGHT (place-images (list BLUB-R
                                          BLUB-Y
                                          BLUB-G)
                                    (list (make-posn 20 MID-H)
                                          (make-posn 50 MID-H)
                                          (make-posn 80 MID-H))
                                    BKG))


; TrafficLight -> TrafficLight
; determines the next state of the traffic light, given
; current-state
(define (tl-next current-state)
  (cond [(string=? "red" current-state) "green"]
        [(string=? "green" current-state) "yellow"]
        [(string=? "yellow" current-state) "red"]))


; TrafficLight -> Image
; renders the current state of the traffic light as an image
; examples:

(define (tl-render current-state)
  (place-image (circle RADIUS "solid" current-state)
               (cond [(string=? "red" current-state) 20]
                     [(string=? "yellow" current-state) 50]
                     [(string=? "green" current-state) 80])
               MID-H
               TRAFFIC-LIGHT))


; TrafficLight -> TrafficLight
; simulates a traffic light that changes with each clock tick
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            [to-draw tl-render]
            [on-tick tl-next]))


; launch
(traffic-light-simulation "red")