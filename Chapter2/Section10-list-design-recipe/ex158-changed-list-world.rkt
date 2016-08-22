;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex158-changed-list-world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


; physical constants
(define HEIGHT 220)
(define WIDTH 30)
(define XSHOT (- (/ WIDTH 2) 5))

; graphical constants
(define BACKGROUND (empty-scene WIDTH HEIGHT "green"))
(define SHOT (rectangle 6 20 "outline" "red"))


; ShotWorld is List-of-numbers
; interpretation each number represents the y-coordinate of shot


; ShotWorld -> ShotWorld
(define (main w0)
  (big-bang w0
            [on-tick tock]
            [on-key keyh]
            [to-draw to-image]))


; ShotWorld -> Image
; adds each y on w at (MID, y) to the background image

(check-expect (to-image '()) BACKGROUND)
(check-expect (to-image (cons 10 '())) (place-image SHOT XSHOT 10 BACKGROUND))
(check-expect (to-image (cons 20 (cons 10 '())))
              (place-image SHOT XSHOT 20
                           (place-image SHOT XSHOT 10 BACKGROUND)))

(define (to-image w)
  (cond [(empty? w) BACKGROUND]
        [(cons? w) (place-image SHOT XSHOT (first w) (to-image (rest w)))]))


; ShotWorld -> ShotWorld
; moves each shot up by one pixel

(check-expect (tock '()) '())
(check-expect (tock (cons 10 '())) (cons 9 '()))
(check-expect (tock (cons 150 (cons 120 '()))) (cons 149 (cons 119 '())))

(define (tock w)
  (cond [(empty? w) '()]
        [(cons? w) (cons (sub1 (first w)) (tock (rest w)))]))


; ShotWorld KeyEvent -> ShotWorld
; adds a shot to the world if the space bar was hit

(check-expect (keyh '() "p") '())
(check-expect (keyh '() " ") (cons HEIGHT '()))

(check-expect (keyh (cons 100 '()) "p") (cons 100 '()))
(check-expect (keyh (cons 100 '()) " ") (cons HEIGHT (cons 100 '())))

(define (keyh w ke)
  (cond [(key=? ke " ") (cons HEIGHT w)]
        [else w]))


 (main '())
; to launch the world.