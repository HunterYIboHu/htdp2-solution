;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex5.6-programing-with-struct) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct posn [x y])
; A Posn is a structure: (make-posn Number Number)
; interpretation the number of pixels from left and from top


(define-struct entry [name phone email])
; An Entry is a structure: (make-entry String String String)
; interpretation
; a contact's name,
; 7-digit phone#, and
; email address


(define-struct ball [location velocity])
; A Ball-1d is a struct:  (make-ball Number Number)
; interpretation 1 the position from top and the velocity
; interpretation 2 the position from left and the velocity


(define-struct ball-2d [location velocity])
; A Ball-2d is a structure:  (make-ball Posn Vel)
; interpretation
; 2-dimensional position with a 2-dimensional velocity

(define-struct vel [deltax deltay])
; A Vel is a structure:  (make-vel Number Number)
; interpretation
; (make-vel dx dy) means a velocity of dx pixels [per tick]
; along the horizontal and dy pixels along the vertical direction
