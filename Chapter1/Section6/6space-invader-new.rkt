;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6space-invader-new) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physical constants
(define WORLD-WIDTH 200)
(define WORLD-HEIGHT (* 3/4 WORLD-WIDTH))
(define MID-WIDTH (/ WORLD-WIDTH 2))
(define MID-HEIGHT (/ WORLD-HEIGHT 2))
(define TANK-HEIGHT 8)
(define MISSILE-START (- WORLD-HEIGHT TANK-HEIGHT 10))

(define FONT-SIZE 12)
(define WIN-COLOR "olive")
(define WIN-MESSAGE "You win! Congratulations!")
(define LOSE-COLOR "red")
(define LOSE-MESSAGE-1 "You lost! Bad news!")
(define LOSE-MESSAGE-2 "You lost! Bad news! Expecially you havn't shot it.")

(define TANK-SPEED 3)
(define UFO-SPEED 8)
(define MISSILE-SPEED (* 2 UFO-SPEED))
(define R 10)
(define DELTA-X 10)

; graphical constants
(define BKG (empty-scene WORLD-WIDTH WORLD-HEIGHT))
(define UFO
  (underlay (rectangle 40 10 "solid" "orange")
            (ellipse 15 15 "solid" "red")))
(define TANK (rectangle 20 TANK-HEIGHT "solid" "green"))
(define MISSILE
  (rotate 180 (polygon (list (make-posn 0 0)
                             (make-posn 5 5)
                             (make-posn 10 0)
                             (make-posn 5 10))
                       "solid"
                       "blue")))
(define R-EDGE (- WORLD-WIDTH (/ (image-width UFO) 2)))
(define L-EDGE (/ (image-width UFO) 2))

; test constants
(define SCENE (place-images (list UFO
                                  TANK)
                            (list (make-posn 20 10)
                                  (make-posn 28 -3))
                           BKG))
(define FIRED (place-image MISSILE
                           28 MISSILE-START
                           SCENE))

; A MissileOrNot is one of:
; - #false
; - Posn
; interpretation #false means the missile hasn't been fired yet;
; Posn says the missile has been fired and is at the specified
; location.

; A UFO is Posn
; interpretion (make-posn x y) is the UFO's current location
; examples:

(define ufo-n (make-posn 20 10))
(define ufo-e (make-posn 45 83))


(define-struct tank [loc vel])
; A Tank is (make-tank Number Number)
; interpretation (make-tank x dx) means the tank is at position
; (x, TANK-HEIGHT) and that it moves dx per clock tick
; examples:

(define tank-n (make-tank 28 -3))
(define tank-e (make-tank 90 3))


(define-struct sigs [ufo tank missile])
; SIGS.v2 (short for version 2)
; is (make-sigs UFO TANK MissileOrNot)
; interpretation represents the state of the space invader game
; examples:

(define start-state (make-sigs (make-posn MID-WIDTH 0)
                               (make-tank L-EDGE TANK-SPEED)
                               #false))
(define just-fired (make-sigs (make-posn 20 10)
                              (make-tank 28 -3)
                              (make-posn 28 MISSILE-START)))
(define shotted (make-sigs (make-posn 20 100)
                           (make-tank 100 3)
                           (make-posn 22 103)))


; ufo Image -> Image
; add the UFO to the specific position on scene
; examples:
(check-expect (ufo-render.v2 ufo-n BKG)
              (place-image UFO
                           (posn-x ufo-n)
                           (posn-y ufo-n)
                           BKG))
(check-expect (ufo-render.v2 ufo-e BKG)
              (place-image UFO
                           (posn-x ufo-e)
                           (posn-y ufo-e)
                           BKG))

(define (ufo-render.v2 u scene)
  (place-image UFO
               (posn-x u)
               (posn-y u)
               BKG))


; tank Image -> Image
; adds the TANK to the specific position on scene
; examples:
(check-expect (tank-render.v2 tank-n BKG)
              (place-image TANK
                           (tank-loc tank-n)
                           WORLD-HEIGHT
                           BKG))
(check-expect (tank-render.v2 tank-e BKG)
              (place-image TANK
                           (tank-loc tank-e)
                           WORLD-HEIGHT
                           BKG))

(define (tank-render.v2 t scene)
  (place-image TANK
               (tank-loc t)
               WORLD-HEIGHT
               scene))


; MissileOrNot Image -> Image
; adds the missile image to sc for m
; examples:
(check-expect (missile-render.v2 #false SCENE) SCENE)
(check-expect (missile-render.v2 (make-posn 28 MISSILE-START)
                                 SCENE)
              FIRED)

(define (missile-render.v2 m scene)
  (cond
    [(boolean? m) scene]
    [(posn? m) (place-image MISSILE
                            (posn-x m)
                            (posn-y m)
                            scene)]))

; SIGS.V2 -> Image
; add UFO, TANK and MISSILE(properly) to BKG on the specfic
; position.
; examples:
(check-expect (si-render.v2 start-state)
              (missile-render.v2 (sigs-missile start-state)
                                 (tank-render.v2 (sigs-tank start-state)
                                                 (ufo-render.v2 (sigs-ufo start-state)
                                                                BKG))))
(check-expect (si-render.v2 just-fired)
              (missile-render.v2 (sigs-missile just-fired)
                                 (tank-render.v2 (sigs-tank just-fired)
                                                 (ufo-render.v2 (sigs-ufo just-fired)
                                                                BKG))))
(check-expect (si-render.v2 shotted)
              (missile-render.v2 (sigs-missile shotted)
                                 (tank-render.v2 (sigs-tank shotted)
                                                 (ufo-render.v2 (sigs-ufo shotted)
                                                                BKG))))

(define (si-render.v2 s)
  (missile-render.v2 (sigs-missile s)
                     (tank-render.v2 (sigs-tank s)
                                     (ufo-render.v2 (sigs-ufo s)
                                                    BKG))))





























