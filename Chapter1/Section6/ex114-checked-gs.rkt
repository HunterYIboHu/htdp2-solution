;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex114-checked-gs) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A UFO is Posn
; interpretation (make-posn x y) is the UFO's current location

(define-struct tank [loc vel])
; A Tank is (make-tank Number Number)
; interpretation (make-tank x dx) means the tank is at position
; (x, HEIGHT) and that it moves dx pixels per clock tick


(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])


; A Missile is Posn
; interpretation (make-posn x y) is the missile's current location




; A SIGS is one of:
; - (make-aim UFO Tank)
; - (make-fired UFO Tank Missile)
; interpretation represents the state of the space invader game.


; Any -> Boolean
; is a an element of the SIGS collection
(check-expect (sigs? (make-aim (make-posn 10 3)
                               (make-tank 10 -3)))
              #true)
(check-expect (sigs? (make-fired (make-posn 30 20)
                                 (make-tank 20 10)
                                 (make-posn 30 9)))
              #true)
(check-expect (sigs? (make-posn 10 20)) #false)

(define (sigs? a)
  (cond [(aim? a) #true]
        [(fired? a) #true]
        [else #false]))


; A Coordinate is one of:
; - a negative number
;    interpretation a point on the Y axis, distance from top
; - a positive number
;    interpretation a point on the X axis, distance from left
; - a Posn
;    interpretation a point in a scene, usual interprataion


; Any -> Boolean
; is a an element of the Coordinate collection
(check-expect (coordinate? 10) #true)
(check-expect (coordinate? -9) #true)
(check-expect (coordinate? (make-posn 10 5)) #true)
(check-expect (coordinate? #true) #false)

(define (coordinate? a)
  (cond [(or (number? a)
             (posn? a))
         #true]
        [else #false]))


(define-struct vcham [pos hp color])
; VCham is (make-vcham Number Number String)
; interpretation (make-vcham p h c) means the cham's position is
; p x-coordinate , his hunge gauge is hg, and his skin is colored
; by c.


(define-struct vcat [pos hp])
; VCat = (make-vcat Number Number)
; interpretation (make-cat p h) means the cat's x-coordinate and
; cat's happiness point.


; VAnimal is either:
; - VCham
; - VCat


; Any -> Boolean
; is a an element of the VAnimal collections
(check-expect (vanimal? (make-vcat 100 100)) #true)
(check-expect (vanimal? (make-vcham 100 100 "red")) #true)
(check-expect (vanimal? #true) #false)

(define (vanimal? a)
  (cond [(or (vcat? a)
             (vcham? a))
         #true]
        [else #false]))
























