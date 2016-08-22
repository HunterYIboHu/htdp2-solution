;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex216-render-final) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


;; data difinitions
(define-struct worm [pos direction])
; a Worm is (make-worm Posn Direction)
; (make-worm p d) p represents the current position, and d is a Direction
; which represent the current moving direction.

; Direction is (list Number Number)
; (list h v) h represent the moving speed in horizenal, negative means left,
; positive means right, 0 means no moving on horizenal;
; v represent the moving speed in vertical, negative means up, positive
; means down,
; 0 means no moving on vertical.


;; graphic constants
(define HEIGHT 500)
(define WIDTH (* HEIGHT 2))
(define MID-HEIGHT (/ HEIGHT 2))
(define MID-WIDTH (/ WIDTH 2))
(define SCENE (empty-scene WIDTH HEIGHT))
(define RADIUS 10)
(define SEGMENT (circle RADIUS "solid" "red"))


;; physical constants
(define UP (list 0 (- 0 (* 2 RADIUS))))
(define DOWN (list 0 (+ 0 (* 2 RADIUS))))
(define LEFT (list (- 0 (* 2 RADIUS)) 0))
(define RIGHT (list (+ 0 (* 2 RADIUS)) 0))


;; struct constants
(define INITIAL (make-worm (make-posn MID-WIDTH MID-HEIGHT)
                           RIGHT))
(define NORMAL (make-worm (make-posn 150 25) UP))
(define OUTSIDE (make-worm (make-posn 995 15) UP))


;; main functions
; Worm -> Worm
(define (worm-main w)
  (big-bang w
            [on-tick worm-move 0.2]
            [on-key keyh]
            [to-draw render]
            [stop-when stop? render-final]))


;; important functions
; Worm -> Worm
; change the pos of the given worm according to the direction of it.

(check-expect (worm-move INITIAL) (make-worm (make-posn (+ MID-WIDTH 20)
                                                        MID-HEIGHT)
                                             RIGHT))
(check-expect (worm-move NORMAL) (make-worm (make-posn 150 (+ 25 -20)) UP))

(define (worm-move w)
  (make-worm (make-posn (+ (posn-x (worm-pos w)) (first (worm-direction w)))
                        (+ (posn-y (worm-pos w)) (second (worm-direction w))))
             (worm-direction w)))


; Worm -> Worm
; determine the direction of the given worm according to the ke.
; if ke is "up", then the direction is set to UP;
; if ke is "down", then the direction is set to DOWN;
; if ke is "left", then the direction is set to LEFT;
; if ke is "right", then the direction is set to RIGHT;
; otherwise the direction won't change.

(check-expect (keyh INITIAL "right") INITIAL)
(check-expect (keyh INITIAL "up") (make-worm (worm-pos INITIAL) UP))
(check-expect (keyh INITIAL "p") INITIAL)
(check-expect (keyh NORMAL "left") (make-worm (worm-pos NORMAL) LEFT))
(check-expect (keyh NORMAL "up") NORMAL)
(check-expect (keyh NORMAL "p") NORMAL)

(define (keyh w ke)
  (make-worm (worm-pos w)
             (cond [(and (key=? "up" ke) (change? (worm-direction w) ke)) UP]
                   [(and (key=? "down" ke) (change? (worm-direction w) ke)) DOWN]
                   [(and (key=? "left" ke) (change? (worm-direction w) ke)) LEFT]
                   [(and (key=? "right" ke) (change? (worm-direction w) ke)) RIGHT]
                   [else (worm-direction w)])))


; Direction -> Boolean
; determine whether the direction can be changed.

(check-expect (change? UP "up") #true)
(check-expect (change? DOWN "up") #false)
(check-expect (change? LEFT "down") #true)
(check-expect (change? RIGHT "left") #false)

(define (change? d ke)
  (not (equal? (cond [(key=? "up" ke) DOWN]
                     [(key=? "down" ke) UP]
                     [(key=? "left" ke) RIGHT]
                     [(key=? "right" ke) LEFT])
               d)))


; Worm -> Image
; add a worm at the specific position on the scene.

(check-expect (render INITIAL) (place-image SEGMENT MID-WIDTH MID-HEIGHT SCENE))
(check-expect (render NORMAL) (place-image SEGMENT 150 25 SCENE))

(define (render w)
  (place-image SEGMENT
               (posn-x (worm-pos w))
               (posn-y (worm-pos w))
               SCENE))


; Worm -> Boolean
; determine whether to end the world program.
; if the pos of given w is over the SCENE, the game will stop.

(check-expect (stop? INITIAL) #false)
(check-expect (stop? NORMAL) #false)
(check-expect (stop? OUTSIDE) #true)

(define (stop? w)
  (or (<= (posn-x (worm-pos w)) RADIUS)
      (<= (posn-y (worm-pos w)) RADIUS)
      (>= (posn-x (worm-pos w)) (- WIDTH RADIUS))
      (>= (posn-y (worm-pos w)) (- HEIGHT RADIUS))))


; Worm -> Image
; add a specific string on lower left of the stop scene.

(check-expect (render-final OUTSIDE)
              (overlay/align "left" "bottom"
                             (text "worm hit border" 24 "balck")
                             (render OUTSIDE)))
(check-expect (render-final (make-worm (make-posn 0 0) UP))
              (overlay/align "left" "bottom"
                             (text "worm hit border" 24 "balck")
                             (render (make-worm (make-posn 0 0) UP))))

(define (render-final w)
  (overlay/align "left" "bottom"
                 (text "worm hit border" 24 "balck")
                 (render w)))


;; launch program
(worm-main INITIAL)