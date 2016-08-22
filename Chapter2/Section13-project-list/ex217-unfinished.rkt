;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex217-unfinished) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; struct constants
(define INITIAL (make-worm (make-posn MID-WIDTH MID-HEIGHT) '() RIGHT))
(define NORMAL (make-worm (make-posn 150 25) '() UP))
(define MULTI-1 (make-worm (make-posn 150 25) TAIL-1 DOWN))
(define MULTI-2 (make-worm (make-posn 150 25) TAIL-2 UP))



;; main functions
; Worm -> Worm
(define (worm-main w)
  (big-bang w
            [on-tick worm-move 0.2]
            [on-key keyh]
            [to-draw render]))


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


;; auxiliary functions
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


;; launch program
(worm-main MULTI-1)