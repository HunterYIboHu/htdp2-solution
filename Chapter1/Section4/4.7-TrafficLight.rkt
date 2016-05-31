;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.7-TrafficLight) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Data constants
(define RED 0)
(define GREEN 1)
(define YELLOW 2)


; A N-TrafficLight shows one of three colors:
; - RED
; - GREEN
; - YELLOW


; physics constants
(define BKG-WIDTH 100)
(define BKG-HEIGHT 30)
(define RADIUS (* 1/3 BKG-HEIGHT))
(define MID-H (/ BKG-HEIGHT 2))
(define POSN-R (* 2 RADIUS))
(define POSN-Y (* 5 RADIUS))
(define POSN-G (* 8 RADIUS))


; graphic constants
(define BKG (empty-scene BKG-WIDTH BKG-HEIGHT))
(define BLUB-R (circle RADIUS "outline" "red"))
(define BLUB-Y (circle RADIUS "outline" "yellow"))
(define BLUB-G (circle RADIUS "outline" "green"))
(define TRAFFIC-LIGHT (place-images (list BLUB-R
                                          BLUB-Y
                                          BLUB-G)
                                    (list (make-posn POSN-R MID-H)
                                          (make-posn POSN-Y MID-H)
                                          (make-posn POSN-G MID-H))
                                    BKG))


; N-TrafficLight -> N-TrafficLight
; determines the next state of the traffic light, given
; current-state
(define (tl-next-numeric current-state)
  (modulo (+ current-state 1) 3))


; S-TrafficLight -> S-TrafficLight
; determines the next state of the traffic light, given cs
(define (tl-next-symbolic cs)
  (cond [(equal? cs RED) GREEN]
        [(equal? cs GREEN) YELLOW]
        [(equal? cs YELLOW) RED]))


; TrafficLight -> TrafficLight
; determines the next state of the traffic light, given
; current-state
; examples:

(check-expect (tl-next 0) 1)
(check-expect (tl-next 1) 2)
(check-expect (tl-next 2) 0)

(define (tl-next current-state)
  (tl-next-numeric current-state))


; TrafficLight Number -> Image
; help rendering the current state of the traffic light
(define (tl-render/auxi cs posn)
  (place-image (circle RADIUS "solid" cs)
               posn MID-H
               TRAFFIC-LIGHT))


; TrafficLight -> Image
; renders the current state of the traffic light as an image
; examples:

(check-expect (tl-render "red") (tl-render/auxi "red" POSN-R))
(check-expect (tl-render "green") (tl-render/auxi "green" POSN-G))
(check-expect (tl-render "yellow") (tl-render/auxi "yellow" POSN-Y))

(define (tl-render current-state)
  (tl-render/auxi current-state
                  (cond [(string=? "red" current-state) POSN-R]
                        [(string=? "yellow" current-state) POSN-Y]
                        [(string=? "green" current-state) POSN-G])))


; TrafficLight -> TrafficLight
; simulates a traffic light that changes with each clock tick
;(define (traffic-light-simulation initial-state)
;  (big-bang initial-state
;            [to-draw tl-render]
;            [on-tick tl-next 1]))
;
;
;; launch
;(traffic-light-simulation "red")