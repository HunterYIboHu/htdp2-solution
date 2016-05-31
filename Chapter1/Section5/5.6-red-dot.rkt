;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.6-red-dot) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; visual constants
(define MTS (empty-scene 100 100))
(define DOT (circle 2 "solid" "red"))

; The state of the world is represented by a Posn.

; Posn -> Posn
(define (main p0)
  (big-bang p0
            [on-tick x+ 1]
            [on-mouse reset-dot]
            [to-draw scene+dot]))


; Posn -> Image
; adds a red spot to MTS at p
; examples:
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))

(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))


; Posn Number -> Posn
; replace the x-coordinate of p with n
; examples:
(check-expect (posn-up-x (make-posn 10 25) 7) (make-posn 7 25))

(define (posn-up-x p n)
  (make-posn n (posn-y p)))


; Posn -> Posn
; increases the x-coordinate of p by 3
; examples:
(check-expect (x+ (make-posn 10 0))
              (posn-up-x (make-posn 10 0) (+ 10 3)))

(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))


; Posn Number Number MouseEvt -> Posn
; for mouse clicks, (make-posn x y); otherwise p
; examples:
(check-expect (reset-dot (make-posn 10 20) 29 31 "button-down")
              (make-posn 29 31))
(check-expect (reset-dot (make-posn 10 20) 29 31 "button-up")
              (make-posn 10 20))

(define (reset-dot p x y me)
  (cond
    [(mouse=? "button-down" me) (make-posn x y)]
    [else p]))

(main (make-posn 50 50))