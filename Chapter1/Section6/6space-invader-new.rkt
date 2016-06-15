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

(define tank-n (make-tank 28 TANK-SPEED))
(define tank-e (make-tank 90 TANK-SPEED))


(define-struct sigs [ufo tank missile])
; SIGS.v2 (short for version 2)
; is (make-sigs UFO TANK MissileOrNot)
; interpretation represents the state of the space invader game
; examples:

(define start-state (make-sigs (make-posn MID-WIDTH 0)
                               (make-tank L-EDGE TANK-SPEED)
                               #false))
(define lost-b (make-sigs (make-posn 20 WORLD-HEIGHT)
                          (make-tank 28 TANK-SPEED)
                          #false))
(define just-fired (make-sigs (make-posn 20 10)
                              (make-tank 28 TANK-SPEED)
                              (make-posn 28 MISSILE-START)))
(define lost (make-sigs (make-posn 20 WORLD-HEIGHT)
                        (make-tank 28 TANK-SPEED)
                        (make-posn 40 20)))
(define shotted (make-sigs (make-posn 20 100)
                           (make-tank 100 TANK-SPEED)
                           (make-posn 22 103)))
(define le (make-sigs (make-posn 20 100)
                      (make-tank L-EDGE TANK-SPEED)
                      (make-posn 22 103)))
(define re (make-sigs (make-posn 20 100)
                      (make-tank R-EDGE TANK-SPEED)
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


; in-reach?
; determine weather the position of two point is less than
; R.if so, return true; else return false.
; examples:
(check-expect (in-reach? (make-posn 3 4)
                         (make-posn 3 6))
              #t)
(check-expect (in-reach? (make-posn 3 10)
                         (make-posn 3 0))
              #f)

(define (in-reach? point-a point-b)
  (if (< (sqrt (+ (sqr (- (posn-x point-a)
                          (posn-x point-b)))
                  (sqr (- (posn-y point-a)
                          (posn-y point-b)))))
         R)
      #true
      #false))


; si-render-final
; SIGS.V2 -> Image
; add the specific message to scene
; examples:
(check-expect (si-render-final lost-b)
              (place-image (text LOSE-MESSAGE-2 FONT-SIZE LOSE-COLOR)
                           MID-WIDTH MID-HEIGHT
                           (si-render.v2 lost-b)))
(check-expect (si-render-final lost)
              (place-image (text LOSE-MESSAGE-1 FONT-SIZE LOSE-COLOR)
                           MID-WIDTH MID-HEIGHT
                           (si-render.v2 lost)))
(check-expect (si-render-final shotted)
              (place-image (text WIN-MESSAGE FONT-SIZE WIN-COLOR)
                           MID-WIDTH MID-HEIGHT
                           (si-render.v2 shotted)))

(define (si-render-final s)
  (place-image (text (cond [(>= (posn-y (sigs-ufo s))
                                WORLD-HEIGHT)
                            (if (boolean? (sigs-missile s))
                                LOSE-MESSAGE-2
                                LOSE-MESSAGE-1)]
                           [else WIN-MESSAGE])
                     FONT-SIZE
                     (if (>= (posn-y (sigs-ufo s))
                             WORLD-HEIGHT)
                         LOSE-COLOR
                         WIN-COLOR))
               MID-WIDTH MID-HEIGHT
               (si-render.v2 s)))


; SIGS.V2 -> Boolean
; determine whether to end the game.
; if the UFO landed, end the game;
; if the UFO is shotted, end the game;
; else continue.
; examples:
(check-expect (si-gameover? start-state) #false)
(check-expect (si-gameover? just-fired) #false)
(check-expect (si-gameover? shotted) #true)
(check-expect (si-gameover? lost) #true)

(define (si-gameover? s)
  (cond [(>= (posn-y (sigs-ufo s))
             WORLD-HEIGHT)
         #true]
        [(and (posn? (sigs-missile s))
              (in-reach? (sigs-missile s)
                         (sigs-ufo s)))
         #true]
        [else #false]))


; si-move-proper
; SIGS.V2 Number-> SIGS.V2
; determine the missile's next position
; examples:
(check-expect (si-move-proper start-state 100)
              (make-sigs (make-posn 100 (+ (posn-y (sigs-ufo start-state))
                                           UFO-SPEED))
                         (sigs-tank start-state)
                         #f))
(check-expect (si-move-proper just-fired 20)
              (make-sigs (make-posn 20 (+ (posn-y (sigs-ufo just-fired))
                                          UFO-SPEED))
                         (sigs-tank just-fired)
                         (make-posn (posn-x (sigs-missile just-fired))
                                    (- (posn-y (sigs-missile just-fired))
                                       MISSILE-SPEED))))

(define (si-move-proper s x)
  (make-sigs (make-posn x
                        (+ (posn-y (sigs-ufo s))
                           UFO-SPEED))
           (sigs-tank s)
           (if (boolean? (sigs-missile s))
               #f
               (make-posn (posn-x (sigs-missile s))
                          (- (posn-y (sigs-missile s))
                             MISSILE-SPEED)))))


; validator
; Number -> Number
; if the given num is overflow either end of the world
; then return the end of the world; else return itself.
; examples:
(check-expect (validator 100) 100)
(check-expect (validator (+ R-EDGE 20)) R-EDGE)
(check-expect (validator (- L-EDGE 20)) L-EDGE)

(define (validator x)
  (cond [(>= x R-EDGE) R-EDGE]
        [(<= x L-EDGE) L-EDGE]
        [else x]))


; create-random-number
; ufo -> Number
; determine the random position of ufo
; use random number to determine the direction,
; and jump DELTA-X px.
; if jump over the end, return the end.
; examples:
(check-random (create-random-number (sigs-ufo start-state))
              (validator (+ (posn-x (sigs-ufo start-state))
                            (* (random DELTA-X)
                               (if (= (random 2) 1) -1 1)))))
(check-random (create-random-number (sigs-ufo shotted))
              (validator (+ (posn-x (sigs-ufo shotted))
                            (* (random DELTA-X)
                               (if (= (random 2) 1) -1 1)))))

(define (create-random-number u)
  (validator (+ (posn-x u) (* (random DELTA-X)
                              (if (= (random 2) 1) -1 1)))))


; si-move
; SIGS.V2 -> SIGS.V2
; determine the next position of UFO and MISSILE
; examples:
(check-random (si-move start-state)
              (si-move-proper start-state
                              (create-random-number (sigs-ufo start-state))))
(check-random (si-move just-fired)
              (si-move-proper just-fired
                              (create-random-number (sigs-ufo just-fired))))

(define (si-move s)
  (si-move-proper s
                  (create-random-number (sigs-ufo s))))


; si-control
; SIGS.V2  KeyEvent -> SIGS.V2
; if press the key "left", then the tank move left TANK-SPEED px,
; unless to the left edge;
; if press the key "right", then the tank move right TANK-SPEED ps,
; unless to the right edge;
; if press the key " "(space), then launch the missile.
; other key don't effect.
; examples:
(check-expect (si-control start-state "left") start-state)
(check-expect (si-control start-state "right")
              (make-sigs (sigs-ufo start-state)
                         (make-tank (+ (tank-loc (sigs-tank start-state))
                                       TANK-SPEED)
                                    (tank-vel (sigs-tank start-state)))
                         (sigs-missile start-state)))
(check-expect (si-control start-state " ")
              (make-sigs (sigs-ufo start-state)
                         (sigs-tank start-state)
                         (make-posn (tank-loc (sigs-tank start-state))
                                    MISSILE-START)))
(check-expect (si-control start-state "b") start-state)

(check-expect (si-control just-fired "left")
              (make-sigs (sigs-ufo just-fired)
                         (make-tank (- (tank-loc (sigs-tank just-fired))
                                       TANK-SPEED)
                                    (tank-vel (sigs-tank just-fired)))
                         (sigs-missile just-fired)))
(check-expect (si-control just-fired "right")
              (make-sigs (sigs-ufo just-fired)
                         (make-tank (+ (tank-loc (sigs-tank just-fired))
                                       TANK-SPEED)
                                    (tank-vel (sigs-tank just-fired)))
                         (sigs-missile just-fired)))
(check-expect (si-control just-fired " ") just-fired)
(check-expect (si-control just-fired "b") just-fired)

(check-expect (si-control le "left") le)
(check-expect (si-control le "right")
              (make-sigs (sigs-ufo le)
                         (make-tank (+ (tank-loc (sigs-tank le))
                                       TANK-SPEED)
                                    (tank-vel (sigs-tank le)))
                         (sigs-missile le)))
(check-expect (si-control le " ") le)
(check-expect (si-control le "b") le)

(check-expect (si-control re "left")
              (make-sigs (sigs-ufo re)
                         (make-tank (- (tank-loc (sigs-tank re))
                                       TANK-SPEED)
                                    (tank-vel (sigs-tank re)))
                         (sigs-missile re)))
(check-expect (si-control re "right") re)
(check-expect (si-control re " ") re)
(check-expect (si-control re "b") re)

(define (si-control s ke)
  (make-sigs (sigs-ufo s)
             (make-tank (cond [(string=? ke "left")
                               (validator (- (tank-loc (sigs-tank s))
                                             TANK-SPEED))]
                              [(string=? ke "right")
                               (validator (+ (tank-loc (sigs-tank s))
                                             TANK-SPEED))]
                              [else (tank-loc (sigs-tank s))])
                        (tank-vel (sigs-tank s)))
             (if (and (string=? ke " ")
                      (boolean? (sigs-missile s)))
                 (make-posn (tank-loc (sigs-tank s))
                            MISSILE-START)
                 (sigs-missile s))))


; SIGS.V2 -> SIGS.V2

(define (space-invader s)
  (big-bang s
            [on-tick si-move 0.2]
            [on-key si-control]
            [to-draw si-render.v2]
            [stop-when si-gameover?
                       si-render-final]))

(space-invader start-state)
















