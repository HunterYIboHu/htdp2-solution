;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex129-check-all) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(check-expect 3 4)

; Answer: 3 not equals 4

(check-member-of "green" "red" "yellow" "grey")

; Answer: "green" is not one of the rest value.

(check-within (make-posn #i1.0 #i1.1) (make-posn #i0.9 #i1.2) 0.01)

; Answer: the distance between the result of the first expression and the second is greater than 0.01

(check-range #i0.9 #i0.6 #i0.8)

; Answer: #i0.9 is not between #i0.6 and #i0.8. 

(check-error (/ 1 1))

; Answer: expression (/ 1 1) returns a value, not raising an error.

(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3)))

; Answer: the random number is not the same.

(check-satisfied 4 odd?)

; Answer: (odd? 4) returns #true