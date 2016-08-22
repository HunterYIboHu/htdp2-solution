;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex218-worm-game.v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


;; graphic constants
(define HEIGHT 500)
(define WIDTH (* HEIGHT 2))
(define MID-HEIGHT (/ HEIGHT 2))
(define MID-WIDTH (/ WIDTH 2))
(define SCENE (empty-scene WIDTH HEIGHT))
(define RADIUS 10)
(define SEGMENT (circle RADIUS "solid" "red"))
(define HIT-WALL (text "hit the wall!" 24 "green"))
(define RAN-INTO-IT-SELF (text "run into worm itself!" 24 "green"))


;; physical constants
(define MOVE (* RADIUS 2))
(define UP (list 0 (- 0 MOVE)))
(define DOWN (list 0 MOVE))
(define LEFT (list (- 0 MOVE) 0))
(define RIGHT (list MOVE 0))


;; data difinitions
; a Segment is a Posn represent the segment's current position

(define SEG-1 (make-posn 170 25))
(define SEG-2 (make-posn 190 25))
(define SEG-3 (make-posn 130 25))
(define SEG-4 (make-posn 110 25))

(define SEG-A (make-posn 170 45))
(define SEG-B (make-posn 150 45))
(define SEG-C (make-posn 130 45))

(define-struct worm [head tail direction])
; a Worm is (make-worm Posn List-of-segments Direction)
; (make-worm p los d) p is the current position of the head of worm,
; los is a list of "connected" segments, and the d is the direction of the
; moving worm.

; Direction is (list Number Number)
; (list h v) h represent the moving speed in horizenal, negative means left,
; positive means right, 0 means no moving on horizenal;
; v represent the moving speed in vertical, negative means up, positive
; means down,
; 0 means no moving on vertical.

; LOS (list of segments) is one of:
; - '()
; - (cons Segment LOS)
; interpretation: represent the posn of the tail.
(define TAIL-1 (list SEG-1 SEG-2))
(define TAIL-2 (list SEG-3 SEG-4))
(define TAIL-W (list SEG-1 SEG-A SEG-B SEG-C))


;; struct constants
(define INITIAL (make-worm (make-posn MID-WIDTH MID-HEIGHT) '() RIGHT))
(define NORMAL (make-worm (make-posn 150 25) '() UP))
(define OUTSIDE (make-worm (make-posn 100 490) '() DOWN))
(define MULTI-1 (make-worm (make-posn 150 25) TAIL-1 DOWN))
(define MULTI-2 (make-worm (make-posn 150 25) TAIL-2 UP))
(define MULTI-W (make-worm (make-posn 150 25) TAIL-W DOWN))
(define MULTI-R (make-worm (make-posn 150 25) TAIL-W UP))
(define INITIAL-2 (make-worm (make-posn 150 25) TAIL-W LEFT))


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

(check-expect (worm-move INITIAL) (make-worm (head-move INITIAL) '() RIGHT))
(check-expect (worm-move MULTI-2) (make-worm (head-move MULTI-2) (list (make-posn 150 25) SEG-3) UP))

(define (worm-move w)
  (make-worm (head-move w)
             (cut-the-last (cons (worm-head w) (worm-tail w)))
             (worm-direction w)))


; Worm KeyEvent -> Worm
; determine the direction of worm according to the ke.
; if ke is "up", then the direction is set to UP;
; if ke is "down", then the direction is set to DOWN;
; if ke is "left", then the direction is set to LEFT;
; if ke is "right", then the direction is set to RIGHT;
; otherwise the direction won't change.

(check-expect (keyh INITIAL "right") INITIAL)
(check-expect (keyh INITIAL "up") (make-worm (worm-head INITIAL)
                                             (worm-tail INITIAL)
                                             UP))
(check-expect (keyh INITIAL "p") INITIAL)
(check-expect (keyh NORMAL "left") (make-worm (worm-head NORMAL)
                                              (worm-tail NORMAL)
                                              LEFT))
(check-expect (keyh NORMAL "up") NORMAL)
(check-expect (keyh NORMAL "p") NORMAL)
(check-expect (keyh MULTI-1 "down") MULTI-1)
(check-expect (keyh MULTI-1 "up") MULTI-1)
(check-expect (keyh MULTI-1 "left") (make-worm (worm-head MULTI-1)
                                               (worm-tail MULTI-1)
                                               LEFT))

(define (keyh w ke)
  (make-worm (worm-head w)
             (worm-tail w)
             (cond [(and (key=? "up" ke) (change? (worm-direction w) ke)) UP]
                   [(and (key=? "down" ke) (change? (worm-direction w) ke)) DOWN]
                   [(and (key=? "left" ke) (change? (worm-direction w) ke)) LEFT]
                   [(and (key=? "right" ke) (change? (worm-direction w) ke)) RIGHT]
                   [else (worm-direction w)])))


; Worm -> Image
; add a worm on the scene.

(check-expect (render INITIAL)
              (place-image SEGMENT MID-WIDTH MID-HEIGHT SCENE))
(check-expect (render MULTI-1)
              (place-images (make-list 3 SEGMENT)
                            (list (make-posn 150 25) SEG-1 SEG-2)
                            SCENE))

(define (render w)
  (place-images (make-list (add1 (length (worm-tail w)))
                           SEGMENT)
                (cons (worm-head w) (worm-tail w))
                SCENE))


; Worm -> Boolean
; determine whether to end the game.Game will end under one of these
; conditions is satisfied:
; - the worm's head run into the wall
; - the worm's head run into itself

(check-expect (stop? INITIAL) #false)
(check-expect (stop? MULTI-1) #false)
(check-expect (stop? (worm-move MULTI-W)) #true)

(define (stop? w)
  (or (hit-the-wall? (worm-head w))
      (member? (worm-head w) (worm-tail w))))


; Worm -> Image
; render the end scene for different reason.

(check-expect (render-final (worm-move MULTI-W))
              (overlay/align "left" "bottom" RAN-INTO-IT-SELF (render (worm-move MULTI-W))))
(check-expect (render-final OUTSIDE)
              (overlay/align "left" "bottom" HIT-WALL (render OUTSIDE)))

(define (render-final w)
  (overlay/align "left" "bottom"
                 (cond [(hit-the-wall? (worm-head w)) HIT-WALL]
                       [else RAN-INTO-IT-SELF])
                 (render w)))


;; auxiliary functions
; Segment -> Boolean
; if the given head's posn is close to wall in one MOVE,
; return #true; else reutrn #false.

(check-expect (hit-the-wall? (make-posn MID-WIDTH MID-HEIGHT)) #false)
(check-expect (hit-the-wall? (make-posn 10000 100)) #true)
(check-expect (hit-the-wall? (make-posn 100 490)) #true)

(define (hit-the-wall? head)
  (not (and (<= MOVE (posn-x head) (- WIDTH MOVE))
            (<= MOVE (posn-y head) (- HEIGHT MOVE)))))


; Worm -> Worm
; determine the current position of worm (without tail) according to the direction.

(check-expect (head-move INITIAL) (make-posn (+ MID-WIDTH 20)
                                             MID-HEIGHT))
(check-expect (head-move NORMAL) (make-posn 150 (+ 25 -20)))

(define (head-move w)
  (make-posn (+ (posn-x (worm-head w)) (first (worm-direction w)))
             (+ (posn-y (worm-head w)) (second (worm-direction w)))))


; Worm -> Worm
; cut the last segment of the given w's tail

(check-expect (cut-the-last (worm-tail MULTI-1)) (list SEG-1))
(check-expect (cut-the-last (worm-tail MULTI-2)) (list SEG-3))

(define (cut-the-last w)
  (cond [(empty? (rest w)) '()]
        [else (cons (first w) (cut-the-last (rest w)))]))


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


;; launch program
(worm-main INITIAL-2)