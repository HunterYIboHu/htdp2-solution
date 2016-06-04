;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6space-invader) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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


(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])


; A UFO is Posn
; interpreattion (make-posn x y) is the UFO's current location
; examples:

(define ufo-n (make-posn 50 50))
(define ufo-e (make-posn 79 34))

(define-struct tank [loc vel])
; A Tank is (make-tank Number Number)
; interpretation (make-tank x dx) means the tank is at position
; (x, TANK-HEIGHT) and that it moves dx per clock tick
; examples:

(define tank-n (make-tank 20 TANK-SPEED))
(define tank-e (make-tank 35 TANK-SPEED))

; A Missle is Posn
; interpretation (make-posn x y) is the missile's current
; location
; examples:
(define missile-n (make-posn 22 103))
(define missile-e (make-posn 56 23))


; A SIGS is one of:
; - (make-aim UFO Tank)
; - (make-fired UFO Tank Missle)
; interpretation represents the state of the space invader game


(define start-state
  (make-aim (make-posn MID-WIDTH 0)
            (make-tank L-EDGE TANK-SPEED)))
(define before-fired
  (make-aim (make-posn 20 10)
            (make-tank 28 -3)))
(define lost-b
  (make-aim (make-posn 20 WORLD-HEIGHT)
            (make-tank 28 3)))
(define just-fired
  (make-fired (make-posn 20 10)
              (make-tank 28 -3)
              (make-posn 28 MISSILE-START)))
(define shotted
  (make-fired (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 22 103)))
(define lost
  (make-fired (make-posn 20 WORLD-HEIGHT)
              (make-tank 100 3)
              (make-posn 60 45)))
(define re
  (make-aim (make-posn 20 100)
            (make-tank R-EDGE TANK-SPEED)))
(define le
  (make-fired (make-posn 20 100)
              (make-tank L-EDGE TANK-SPEED)
              (make-posn 20 120)))

; Tank Image -> Image
; adds t to the given image im
; examples:
(check-expect (tank-render tank-n BKG)
              (place-image TANK
                           (tank-loc tank-n)
                           WORLD-HEIGHT
                           BKG))
(check-expect (tank-render tank-e BKG)
              (place-image TANK
                           (tank-loc tank-e)
                           WORLD-HEIGHT
                           BKG))

(define (tank-render t im)
  (place-image TANK (tank-loc t) WORLD-HEIGHT im))


; UFO Image -> Image
; adds u to the given image im
; examples:
(check-expect (ufo-render ufo-n BKG)
              (place-image UFO
                           (posn-x ufo-n)
                           (posn-y ufo-n)
                           BKG))
(check-expect (ufo-render ufo-e BKG)
              (place-image UFO
                           (posn-x ufo-e)
                           (posn-y ufo-e)
                           BKG))

(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))


; Missile Image -> Image
; adds m to the given image im
; examples:
(check-expect (missile-render missile-n BKG)
              (place-image MISSILE
                           (posn-x missile-n)
                           (posn-y missile-n)
                           BKG))
(check-expect (missile-render missile-e BKG)
              (place-image MISSILE
                           (posn-x missile-e)
                           (posn-y missile-e)
                           BKG))

(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))

; SIGS -> Image
; ads TANK, UFO, and possibly the MISSILE to BKG
; examples:
(check-expect (si-render before-fired)
              (tank-render (aim-tank before-fired)
                           (ufo-render (aim-ufo before-fired)
                                       BKG)))
(check-expect (si-render just-fired)
              (tank-render (fired-tank just-fired)
                           (ufo-render (fired-ufo just-fired)
                                       (missile-render (fired-missile just-fired)
                                                       BKG))))
(check-expect (si-render shotted)
              (tank-render (fired-tank shotted)
                           (ufo-render (fired-ufo shotted)
                                       (missile-render (fired-missile shotted)
                                                       BKG))))

(define (si-render s)
  (cond [(aim? s)
         (tank-render (aim-tank s)
                      (ufo-render (aim-ufo s) BKG))]
        [(fired? s)
         (tank-render (fired-tank s)
                      (ufo-render (fired-ufo s)
                                  (missile-render (fired-missile s)
                                                  BKG)))]))


; si-render-final
; SIGS -> Image
; adds the text to result of si-render when
; stop-when return #t.
; examples:
; si-render-final
; SIGS -> Image
; adds the text to result of si-render when
; stop-when return #t.
; examples:
(check-expect (si-render-final lost-b)
              (place-image (text LOSE-MESSAGE-2
                                 FONT-SIZE LOSE-COLOR)
                           MID-WIDTH MID-HEIGHT (si-render lost-b)))
(check-expect (si-render-final lost)
              (place-image (text LOSE-MESSAGE-1 FONT-SIZE LOSE-COLOR)
                           MID-WIDTH MID-HEIGHT (si-render lost)))
(check-expect (si-render-final shotted)
              (place-image (text WIN-MESSAGE FONT-SIZE WIN-COLOR)
                           MID-WIDTH MID-HEIGHT (si-render shotted)))

(define (si-render-final s)
  (place-image
   (cond [(fired? s)
          (if (in-reach? (fired-ufo s)
                         (fired-missile s))
              (text WIN-MESSAGE FONT-SIZE WIN-COLOR)
              (text LOSE-MESSAGE-1 FONT-SIZE LOSE-COLOR))]
         [else (text LOSE-MESSAGE-2 FONT-SIZE LOSE-COLOR)])
   MID-WIDTH MID-HEIGHT (si-render s)))


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


; SIGS -> Boolean
; determine weather to stop the game.
; if the UFO's y-coordinate is >= WORLD-HEIGHT,
; return #t; else if the missile is in reach of UFO,
; reutnr #t; else return #f.
; examples:
(check-expect (si-game-over? before-fired) #f)
(check-expect (si-game-over? just-fired) #f)
(check-expect (si-game-over? lost-b) #t)
(check-expect (si-game-over? shotted) #t)
(check-expect (si-game-over? lost) #t)

(define (si-game-over? s)
  (cond [(aim? s)
         (if (>= (posn-y (aim-ufo s)) WORLD-HEIGHT)
             #true
             #false)]
        [(fired? s)
         (cond [(>= (posn-y (fired-ufo s)) WORLD-HEIGHT) #true]
               [(in-reach? (fired-ufo s) (fired-missile s)) #true]
               [else #false])]))


; Number -> Number
; determine weather the height of ufo have reach the end.
; examples:
(check-expect (validator-end 10) 10)
(check-expect (validator-end (+ 10 WORLD-HEIGHT))
              WORLD-HEIGHT)

(define (validator-end h)
  (if (> h WORLD-HEIGHT)
      WORLD-HEIGHT
      h))


; SIGS Number -> SIGS
; help determine the next SIGS
; if consume a SIGS, then state must be fired.
; examples:
(check-expect (si-move-proper before-fired 100)
              (make-aim
               (make-posn 100
                          (+ (posn-y (aim-ufo before-fired))
                             UFO-SPEED))
               (aim-tank before-fired)))
(check-expect (si-move-proper shotted 100)
              (make-fired
               (make-posn 100
                          (+ (posn-y (fired-ufo shotted))
                             UFO-SPEED))
               (fired-tank shotted)
               (make-posn (posn-x (fired-missile shotted))
                          (- (posn-y (fired-missile shotted))
                             MISSILE-SPEED))))

(define (si-move-proper w x)
  (cond [(aim? w)
         (make-aim (make-posn x
                              (+ (posn-y (aim-ufo w))
                                 UFO-SPEED))
                   (aim-tank w))]
        [(fired? w)
         (make-fired (make-posn x
                                (+ (posn-y (fired-ufo w))
                                   UFO-SPEED))
                     (fired-tank w)
                     (make-posn (posn-x (fired-missile w))
                                (- (posn-y (fired-missile w))
                                   MISSILE-SPEED)))]))


; Number -> Number
; determine weather the ufo's x-coordinate is overflow
; examples:
(check-expect (validator -10) L-EDGE)
(check-expect (validator (+ 10 R-EDGE)) R-EDGE)
(check-expect (validator 100) 100)

(define (validator x)
  (cond [(> x R-EDGE) R-EDGE]
        [(< x L-EDGE) L-EDGE]
        [else x]))


; UFO -> Number
; create a random number in case a UFO should perform a
; horizontal jump. the (= (random 2) 1) exp is to
; determine weather the num is negative.
; examples:
(check-random (create-random-number ufo-n)
              (validator (+ (posn-x ufo-n)
                            (* (random DELTA-X)
                               (if (= (random 2) 1) -1 1)))))
(check-random (create-random-number ufo-e)
              (validator (+ (posn-x ufo-e)
                            (* (random DELTA-X)
                               (if (= (random 2) 1) -1 1)))))

(define (create-random-number u)
  (validator(+ (posn-x u) (* (random DELTA-X)
                             (if (= (random 2) 1) -1 1)))))


; si-move
; SIGS -> SIGS
; determine the next position of UFO and Missile
; using the velocity of them to compute it.
; examples:
(check-random (si-move before-fired)
              (si-move-proper before-fired
                              (create-random-number (aim-ufo before-fired))))
(check-random (si-move just-fired)
              (si-move-proper just-fired
                              (create-random-number (fired-ufo just-fired))))


(define (si-move w)
  (si-move-proper w
                  (create-random-number
                   (if (aim? w)
                       (aim-ufo w)
                       (fired-ufo w)))))


; si-control
; SIGS KeyEvent -> SIGS
; determine the next SIGS after player press key.
; if KeyEvent is "left",
; sub TANK-SPEED pixels to tank's x-coordinate unless to the left end
; if KeyEvent is "right",
; add TANK-SPEED pixels to tank's x-coordinate, unless to the right end
; if KeyEvent is " "(space),
; fired the Missile, change SIGS to fired.
; else just ignore it.
; examples:
; the state if aim
(check-expect (si-control before-fired "left")
              (make-aim (aim-ufo before-fired)
                        (make-tank (validator
                                    (- (tank-loc (aim-tank before-fired))
                                       (tank-vel (aim-tank before-fired))))
                                   (tank-vel (aim-tank before-fired)))))
(check-expect (si-control before-fired "right")
              (make-aim (aim-ufo before-fired)
                        (make-tank (validator
                                    (+ (tank-loc (aim-tank before-fired))
                                       (tank-vel (aim-tank before-fired))))
                                   (tank-vel (aim-tank before-fired)))))
(check-expect (si-control before-fired " ")
              (make-fired (aim-ufo before-fired)
                          (aim-tank before-fired)
                          (make-posn (tank-loc (aim-tank before-fired))
                                     MISSILE-START)))
(check-expect (si-control before-fired "p") before-fired)

; the state is fired
(check-expect (si-control just-fired "left")
              (make-fired (fired-ufo just-fired)
                          (make-tank (validator
                                      (- (tank-loc (fired-tank just-fired))
                                         (tank-vel (fired-tank just-fired))))
                                     (tank-vel (fired-tank just-fired)))
                          (fired-missile just-fired)))
(check-expect (si-control just-fired "right")
              (make-fired (fired-ufo just-fired)
                          (make-tank (validator
                                      (+ (tank-loc (fired-tank just-fired))
                                         (tank-vel (fired-tank just-fired))))
                                     (tank-vel (fired-tank just-fired)))
                          (fired-missile just-fired)))
(check-expect (si-control just-fired " ") just-fired)
(check-expect (si-control just-fired "p") just-fired)

; the state is when meet the right end.(state aim)
(check-expect (si-control re "left")
              (make-aim (aim-ufo re)
                        (make-tank (- (tank-loc (aim-tank re))
                                      (tank-vel (aim-tank re)))
                                   (tank-vel (aim-tank re)))))
(check-expect (si-control re "right") re)
(check-expect (si-control re " ")
              (make-fired (aim-ufo re)
                          (aim-tank re)
                          (make-posn (tank-loc (aim-tank re))
                                     MISSILE-START)))
(check-expect (si-control re "p") re)

; special one, the state when meet the left end.(state fired)
(check-expect (si-control le "left") le)
(check-expect (si-control le "right")
              (make-fired (fired-ufo le)
                          (make-tank (+ (tank-loc (fired-tank le))
                                        (tank-vel (fired-tank le)))
                                     (tank-vel (fired-tank le)))
                          (fired-missile le)))
(check-expect (si-control le " ") le)
(check-expect (si-control le "p") le)

(define (si-control w ke)
  (cond [(aim? w)
         (cond [(string=? "left" ke)
                (make-aim (aim-ufo w)
                          (make-tank (validator (- (tank-loc (aim-tank w))
                                                   (tank-vel (aim-tank w))))
                                     (tank-vel (aim-tank w))))]
               [(string=? "right" ke)
                (make-aim (aim-ufo w)
                          (make-tank (validator (+ (tank-loc (aim-tank w))
                                                   (tank-vel (aim-tank w))))
                                     (tank-vel (aim-tank w))))]
               [(string=? " " ke)
                (make-fired (aim-ufo w)
                            (aim-tank w)
                            (make-posn (tank-loc (aim-tank w))
                                       MISSILE-START))]
               [else w])]
        [(fired? w)
         (cond [(string=? "left" ke)
                (make-fired (fired-ufo w)
                            (make-tank (validator (- (tank-loc (fired-tank w))
                                                     (tank-vel (fired-tank w))))
                                       (tank-vel (fired-tank w)))
                            (fired-missile w))]
               [(string=? "right" ke)
                (make-fired (fired-ufo w)
                            (make-tank (validator (+ (tank-loc (fired-tank w))
                                                     (tank-vel (fired-tank w))))
                                       (tank-vel (fired-tank w)))
                            (fired-missile w))]
               [else w])]))

; SIGS -> SIGS
; using big-bang to launch the game.
(define (space-invader w)
  (big-bang w
            [on-tick si-move 0.2]
            [on-key si-control]
            [to-draw si-render]
            [stop-when si-game-over?
                       si-render-final]))


(space-invader start-state)