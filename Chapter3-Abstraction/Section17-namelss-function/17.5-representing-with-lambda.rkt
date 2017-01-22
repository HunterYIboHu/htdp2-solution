;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 17.5-representing-with-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Shape is a function: 
;   [Posn -> Boolean]
; interpretation if s is a shape and p a Posn, (s p) 
; produces #true if p is in of s, #false otherwise


; Number Number -> Shape
; represents a point at (x, y)

(check-expect (inside? (mk-point 3 4) (make-posn 3 4)) #true)
(check-expect (inside? (mk-point 3 4) (make-posn 3 5)) #false)

(define (mk-point x y)
  (lambda (p)
    (and (= (posn-x p) x) (= (posn-y p) y))))

(define a-sample-shape (mk-point 3 4))


; Number Number Number -> Shape
; creates a representation for a circle of radius r
; located at (center-x, center-y)

(check-expect
 (inside? (mk-circle 3 4 5) (make-posn 0 0)) #true)
(check-expect
 (inside? (mk-circle 3 4 5) (make-posn 0 9)) #false)
(check-expect
 (inside? (mk-circle 3 4 5) (make-posn -1 3)) #true)

(define (mk-circle center-x center-y r)
  (lambda (p)
    (local (; Posn -> Number
            ; computes the distance between the given p and
            ; (make-posn cneter-x center-y).
            (define (distance-between p)
              (sqrt (+ (sqr (- (posn-x p) center-x))
                       (sqr (- (posn-y p) center-y))))))
      (<= (distance-between p) r))))


; Number Number Number Number -> Shape
; represent a width by height rectangle whose 
; upper-left corner is located at (ul-x, ul-y)
 
(check-expect (inside? (mk-rect 0 0 10 3)
                       (make-posn 0 0))
              #true)
(check-expect (inside? (mk-rect 2 3 10 3)
                       (make-posn 4 5))
              #true)
(check-expect (inside? (mk-rect 2 3 10 3)
                       (make-posn 100 2))
              #false)
 
(define (mk-rect ul-x ul-y width height)
  (lambda (p)
    (and (<= ul-x (posn-x p) (+ ul-x width))
         (<= ul-y (posn-y p) (+ ul-y height)))))


; Shape Shape -> Shape
(define (mk-combination s1 s2)
  ; Posn -> Boolean
  (lambda (p)
    (or (inside? s1 p) (inside? s2 p))))


;; auxiliary functions
; Shape Posn -> Boolean
(define (inside? s p)
  (s p))

