;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex99-space-invader) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physical constants
(define WORLD-WIDTH 200)
(define WORLD-HEIGHT (* 3/4 WORLD-WIDTH))
(define MID-WIDTH (/ WORLD-WIDTH 2))
(define MID-HEIGHT (/ WORLD-HEIGHT 2))
(define TANK-HEIGHT 8)

(define FONT-SIZE 36)
(define WIN-COLOR "olive")
(define WIN-MESSAGE "You win! Congratulations!")
(define LOSE-COLOR "red")
(define LOSE-MESSAGE-1 "You lost! Bad news!")
(define LOST-MESSAGE-2 "You lost! Bad news! Expecially you havn't shot it.")

(define TANK-SPEED 3)
(define UFO-SPEED 4)
(define MISSLE-SPEED (* 2 UFO-SPEED))
(define R 5)

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


(define before-fired
  (make-aim (make-posn 20 10)
            (make-tank 28 -3)))
(define lost-b
  (make-aim (make-posn 20 WORLD-HEIGHT)
            (make-tank 28 3)))
(define just-fired
  (make-fired (make-posn 20 10)
              (make-tank 28 -3)
              (make-posn 28 (- WORLD-HEIGHT TANK-HEIGHT 10))))
(define shotted
  (make-fired (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 22 103)))
(define lost
  (make-fired (make-posn 20 WORLD-HEIGHT)
              (make-tank 100 3)
              (make-posn 60 45)))

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









