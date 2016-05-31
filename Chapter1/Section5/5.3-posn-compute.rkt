;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.3-posn-compute) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Posn -> Number
; computes the distance of a-posn to the origin
; example:

(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 6 8)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

(define (distance-to-0 a-posn)
  (sqrt (+ (sqr (posn-x a-posn))
           (sqr (posn-y a-posn)))))


; ex65
(distance-to-0 (make-posn 3 4))
(distance-to-0 (make-posn 6 (* 2 4)))
(+ (distance-to-0 (make-posn 12 5)) 10)


; ex66
; Posn -> Number
; computes the Manhattan distance of a-posn to the orign
; example:

(check-expect (manhattan-distance-to-0 (make-posn 3 4)) 7)
(check-expect (manhattan-distance-to-0 (make-posn 6 8)) 14)
(check-expect (manhattan-distance-to-0 (make-posn -3 1)) 4)

(define (manhattan-distance a-posn)
  (+ (abs (posn-x a-posn))
     (abs (posn-y a-posn))))





