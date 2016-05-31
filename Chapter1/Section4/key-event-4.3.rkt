;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname key-event-4.3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define RADIUS 10)
(define BALL
  (circle RADIUS "solid" "red"))

(define WIDTH-OF-WORLD (* 20 RADIUS))
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 2))
(define BACKGROUND
  (empty-scene WIDTH-OF-WORLD
               HEIGHT-OF-WORLD))
(define Y-BALL (- HEIGHT-OF-WORLD RADIUS))

; Position is a Number
; interpretation distance between the left margin and the ball

; Position KeyEvent -> Position
; computes the next location of the ball

(check-expect (keh 13 "left") 8)
(check-expect (keh 13 "right") 18)
(check-expect (keh 13 "a") 13)

(define (keh p k)
  (cond [(string=? "left" k) (- p 5)]
        [(string=? "right" k) (+ p 5)]
        [else p]))


; Position -> Position
; if the Position is over right edge, then reset it to 0;
; else if the Position is over left edge, then reset it to R-EDGE

;(define (tock p)
;  ... p ...)


; Position -> Image
; render the position to the BALL place in BACKGROUND
(define (render p)
  (place-image BALL
               p Y-BALL
               BACKGROUND))


; launch
(define (roll-ball p)
  (big-bang p
            [on-key keh]
            [to-draw render]))

(roll-ball 0)













