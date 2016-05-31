;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.8-3d) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct r3 [x y z])
; R3 is (make-r3 Numebr Number Number)

(define ex1 (make-r3 3 4 12))
(define ex2 (make-r3 -4 0 3))
(define ex3 (make-r3 5 -12 0))
(define ex4 (make-r3 0 6 8))


; Number Number Number -> Numebr
; computes all the (sqr x) and add them all
; then computes the sqrt of the sum
(define (r3-distance/auxi x y z)
  (sqrt (+ (sqr x)
           (sqr y)
           (sqr z))))


; R3 -> Number
; determines the distance of p to the orign
; examples:
(check-expect (r3-distance ex1) (r3-distance/auxi (r3-x ex1)
                                                  (r3-y ex1)
                                                  (r3-z ex1)))
(check-expect (r3-distance ex2) (r3-distance/auxi (r3-x ex2)
                                                  (r3-y ex2)
                                                  (r3-z ex2)))
(check-expect (r3-distance ex3) (r3-distance/auxi (r3-x ex3)
                                                  (r3-y ex3)
                                                  (r3-z ex3)))
(check-expect (r3-distance ex4) (r3-distance/auxi (r3-x ex4)
                                                  (r3-y ex4)
                                                  (r3-z ex4)))

(define (r3-distance p)
  (r3-distance/auxi (r3-x p) (r3-y p) (r3-z p)))