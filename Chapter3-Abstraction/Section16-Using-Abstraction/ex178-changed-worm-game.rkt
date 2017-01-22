;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex178-changed-worm-game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


;; graphic constants
(define RADIUS 10)
(define HEIGHT (* 50 RADIUS))
(define WIDTH (* HEIGHT 2))
(define MID-HEIGHT (/ HEIGHT 2))
(define MID-WIDTH (/ WIDTH 2))
(define SCENE (empty-scene WIDTH HEIGHT))
(define SEGMENT (circle RADIUS "solid" "red"))
(define FOOD (circle RADIUS "solid" "black"))
(define HIT-WALL (text "hit the wall!" 24 "green"))
(define RAN-INTO-IT-SELF (text "run into worm itself!" 24 "green"))


;; physical constants
(define MOVE (* RADIUS 2))
(define UP (make-posn 0 (- 0 MOVE)))
(define DOWN (make-posn 0 MOVE))
(define LEFT (make-posn (- 0 MOVE) 0))
(define RIGHT (make-posn MOVE 0))


;; data difinitions
; a Segment is a Posn represent the segment's current position

(define SEG-1 (make-posn 170 25))
(define SEG-2 (make-posn 190 25))
(define SEG-3 (make-posn 130 25))
(define SEG-4 (make-posn 110 25))

(define SEG-A (make-posn 170 45))
(define SEG-B (make-posn 150 45))
(define SEG-C (make-posn 130 45))

(define-struct worm [head tail direction food])
; a Worm is (make-worm Posn List-of-segments Direction Posn)
; (make-worm p los d f) p is the current position of the head of worm,
; los is a list of "connected" segments, the d is the direction of the
; moving worm, and the f is the current position of food.

; Direction is a Posn
; the posn-x means the addition of x-coordinate, the posn-y means the
; addition of y-coordinate.


; [List-of Segment]
(define TAIL-1 (list SEG-1 SEG-2))
(define TAIL-2 (list SEG-3 SEG-4))
(define TAIL-W (list SEG-1 SEG-A SEG-B SEG-C))


;; struct constants
(define WRONG-FOOD (make-posn 970 470))

(define INITIAL (make-worm (make-posn MID-WIDTH MID-HEIGHT) '() RIGHT WRONG-FOOD))
(define NORMAL (make-worm (make-posn 150 25) '() UP WRONG-FOOD))
(define OUTSIDE (make-worm (make-posn 100 510) '() DOWN WRONG-FOOD))
(define MULTI-1 (make-worm (make-posn 150 25) TAIL-1 DOWN WRONG-FOOD))
(define MULTI-2 (make-worm (make-posn 150 25) TAIL-2 UP WRONG-FOOD))
(define MULTI-W (make-worm (make-posn 150 25) TAIL-W DOWN WRONG-FOOD))
(define MULTI-R (make-worm (make-posn 150 25) TAIL-W UP WRONG-FOOD))
(define INITIAL-2 (make-worm (make-posn 150 25) TAIL-W LEFT WRONG-FOOD))


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
; determine the current position of the given worm's head and tail according
; to the direction of it.

(check-expect (worm-move INITIAL) (make-worm (head-move INITIAL) '() RIGHT WRONG-FOOD))
(check-expect (worm-move MULTI-2) (make-worm (head-move MULTI-2) (list (make-posn 150 25) SEG-3) UP WRONG-FOOD))

(define (worm-move w)
  (local (; Worm -> Posn
          ; compute the next position of the worm's head according to the
          ; current position of head and the direction.
          (define head-pos
            (local ((define head-direction `(,(worm-head w) ,(worm-direction w)))
                    (define BASE 0)
                    ; [Posn -> Number] -> Number
                    ; compute the number represents the coordinate according to the given function
                    (define (posn->number func)
                      (foldr + BASE (map func head-direction))))
              (make-posn (posn->number posn-x)
                         (posn->number posn-y))))
          ; [List-of X] -> [List-of X]
          ; remove the last item of the given list.
          (define (cut-the-last l)
            (reverse (rest (reverse l)))))
    (cond [(equal? head-pos (worm-food w))
           (make-worm head-pos
                      (cons (worm-head w) (worm-tail w))
                      (worm-direction w)
                      (random-food w))]
          [else (make-worm head-pos
                           (cut-the-last (cons (worm-head w) (worm-tail w)))
                           (worm-direction w)
                           (worm-food w))])))


; Worm -> Image
; render a worm on the scene.

(check-expect (render INITIAL)
              (place-images (list FOOD SEGMENT)
                            (list WRONG-FOOD (make-posn MID-WIDTH MID-HEIGHT))
                            SCENE))
(check-expect (render MULTI-1)
              (place-images (cons FOOD (make-list 3 SEGMENT))
                            (list WRONG-FOOD (make-posn 150 25) SEG-1 SEG-2)
                            SCENE))

(define (render w)
  (local ((define whole (cons (worm-head w) (worm-tail w)))
          (define food (worm-food w))
          ; Posn Image-> Image
          ; place a food image on the given image at the specific posn.
          (define (place-food pos scene)
            (place-image FOOD (posn-x pos) (posn-y pos) scene))
          (define (place-seg pos scene)
            (place-image SEGMENT (posn-x pos) (posn-y pos) scene)))
    (place-food food (foldr place-seg SCENE whole))))


; Worm KeyEvent -> Worm
; determine the direction of worm according to the ke.
; if ke is "up", then the direction is set to UP;
; if ke is "down", then the direction is set to DOWN;
; if ke is "left", then the direction is set to LEFT;
; if ke is "right", then the direction is set to RIGHT;
; otherwise the direction won't change.
;
(check-expect (keyh INITIAL "right") INITIAL)
(check-expect (keyh INITIAL "up") (make-worm (worm-head INITIAL)
                                             (worm-tail INITIAL)
                                             UP
                                             WRONG-FOOD))
(check-expect (keyh INITIAL "p") INITIAL)
(check-expect (keyh NORMAL "left") (make-worm (worm-head NORMAL)
                                              (worm-tail NORMAL)
                                              LEFT
                                              WRONG-FOOD))
(check-expect (keyh NORMAL "up") NORMAL)
(check-expect (keyh NORMAL "p") NORMAL)
(check-expect (keyh MULTI-1 "down") MULTI-1)
(check-expect (keyh MULTI-1 "up") MULTI-1)
(check-expect (keyh MULTI-1 "left") (make-worm (worm-head MULTI-1)
                                               (worm-tail MULTI-1)
                                               LEFT
                                               WRONG-FOOD))

(define (keyh w ke)
  (local ((define DIRECTIONS `(("up" ,UP) ("down" ,DOWN) ("left" ,LEFT) ("right" ,RIGHT)))
          (define change-d (assoc ke DIRECTIONS))
          (define current-d (worm-direction w))
          ; Direction '(KeyEvent Direction)-> Direction
          ; determine whether the direction can be changed.
          (define (change loked)
            (local ((define direction (second loked)))
              (if (or (= (abs (posn-x current-d)) (abs (posn-x direction)))
                      (= (abs (posn-y current-d)) (abs (posn-y direction))))
                  current-d
                  direction))))
    (make-worm (worm-head w)
               (worm-tail w)
               (if (cons? change-d) (change change-d) current-d)
               (worm-food w))))


; Worm -> Boolean
; determine whether to end the game.Game will end under one of these
; conditions is satisfied:
; - the worm's head run into the wall
; - the worm's head run into itself

(check-expect (stop? INITIAL) #false)
(check-expect (stop? MULTI-1) #false)
(check-expect (stop? (worm-move MULTI-W)) #true)

(define (stop? w)
  (local ((define pos-of-head (worm-head w)))
    (or (hit-the-wall pos-of-head)
        (member? pos-of-head (worm-tail w)))))


; Worm -> Image
; render the end scene for different reason.

(check-expect (render-final (worm-move MULTI-W))
              (overlay/align "left" "bottom" RAN-INTO-IT-SELF (render (worm-move MULTI-W))))
(check-expect (render-final OUTSIDE)
              (overlay/align "left" "bottom" HIT-WALL (render OUTSIDE)))

(define (render-final w)
  (overlay/align "left" "bottom"
                 (if (hit-the-wall (worm-head w))
                     HIT-WALL
                     RAN-INTO-IT-SELF)
                 (render w)))


;; auxiliary functions, waiting for deleting.
; Worm -> Posn
; compute the next position of the worm's head according to the
; current position of head and the direction.

(check-expect (head-move INITIAL) (make-posn (+ MID-WIDTH 20)
                                             MID-HEIGHT))
(check-expect (head-move NORMAL) (make-posn 150 (+ 25 -20)))

(define (head-move w)
  (local ((define head-direction `(,(worm-head w) ,(worm-direction w)))
          (define BASE 0)
          ; [Posn -> Number] -> Number
          ; compute the number represents the coordinate according to the given function
          (define (posn->number func)
            (foldr + BASE (map func head-direction))))
    (make-posn (posn->number posn-x)
               (posn->number posn-y))))


; Worm -> Posn
; produces a new Posn which different from the head, tail and old food.
; Here different means far away from them at least one MOVE, no matter
; x-coordinate or y-coordinate.

(check-random (random-food INITIAL) (local (; Number -> Number
                                            ; produce a random number according to a formulate and the max.
                                            (define (random-coor max)
                                              (- (* (add1 (random max)) MOVE) RADIUS)))
                                      (make-posn (random-coor 50) (random-coor 25))))
(check-random (random-food MULTI-1) (local (; Number -> Number
                                            ; produce a random number according to a formulate and the max.
                                            (define (random-coor max)
                                              (- (* (add1 (random max)) MOVE) RADIUS)))
                                      (make-posn (random-coor 50) (random-coor 25))))

(define (random-food w)
  (local ((define current-posns `(,(worm-food w) ,@(cons (worm-head w) (worm-tail w))))
          (define current-food
            (local (; Number -> Number
                    ; produce a random number according to a formulate and the max.
                    (define (random-coor max)
                      (- (* (add1 (random max)) MOVE) RADIUS)))
              (make-posn (random-coor 50) (random-coor 25))))
          ; Posn Posn -> Boolean
          ; determine whether the given two posns are the same posn.
          (define (posn=? food)
            (and (= (posn-x current-food) (posn-x food))
                 (= (posn-y current-food) (posn-y food)))))
    (if (empty? (filter posn=? current-posns))
        current-food
        (random-food w))))


; Posn -> Boolean
; determine whether the head hit the wall

(check-expect (hit-the-wall (make-posn MID-WIDTH MID-HEIGHT)) #false)
(check-expect (hit-the-wall (make-posn 10000 100)) #true)
(check-expect (hit-the-wall (make-posn 100 510)) #true)

(define (hit-the-wall pos)
  (not (and (< 0 (posn-x pos) WIDTH)
            (< 0 (posn-y pos) HEIGHT))))


;; launch game.
(worm-main (make-worm (make-posn 30 30) '() RIGHT (random-food NORMAL)))