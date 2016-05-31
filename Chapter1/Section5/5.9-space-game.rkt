;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.9-space-game) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct space-game [ufo tank])
; Space-game is (make-space-game Number Number)
; interpretation space-game means the world state of game
; ufo means the current UFO's y-coordinate
; tank means the current TANK's x-coordinate

(define sg1 (make-space-game 10 20))
(define sg2 (make-space-game 0 0))

(space-game-ufo sg1)
(space-game-tank sg2)
(space-game? sg1)
(space-game? "123")


; SpaceGame is (make-space-game Posn Number)
; interpretation (make-space-game (make-posn ux uy) tx) means that
; the UFO is currently at (ux, uy) and the tank's x-coordinate is
; tx.