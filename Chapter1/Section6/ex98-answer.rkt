;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex98-answer) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physical constants
(define WORLD-WIDTH 200)
(define WORLD-HEIGHT (* 3/4 WORLD-WIDTH))
(define TANK-HEIGHT 8)

(define TANK-SPEED 5)
(define UFO-SPEED 8)
(define MISSLE-SPEED (* 2 UFO-SPEED))

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
(define just-fired
  (make-fired (make-posn 20 10)
              (make-tank 28 -3)
              (make-posn 28 (- WORLD-HEIGHT TANK-HEIGHT 10))))
(define shotted
  (make-fired (make-posn 20 100)
              (make-tank 100 3)
              (make-posn 22 103)))


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



; Answer to ex98
; the answer determine by the position of tank and ufo.
; if ufo's position is diffierent from tank's, that is same.
; else will be different.
; Because the nested order will determine which picture is above the other.

; 练习98的答案
; 这题的答案取决于坦克和UFO的位置。如果这两个东西的位置没有重合，则顺序的改变没有影响；
; 如果其位置重合，则会有影响。这是因为：函数嵌套的顺序决定了那张图像在其他图像之上。