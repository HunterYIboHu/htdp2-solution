;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex297-distance-between) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; auxiliary functions
; Shape Posn -> Boolean
(define (inside? s p)
  (s p))


;; Question
;; Q1: Use compass-and-pencil drawings to check the tests
;; A1: I don't have this.