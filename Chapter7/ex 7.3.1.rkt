;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |ex 7.3.1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Version 1:

;; Data Definition:
(define-struct circle (center radius))
(define-struct square (nw length))
(define-struct rectangle (uc width height))
;; A shape is either
;; 1. a structure: (make-circle p s)
;;    where p is a posn, s a number;
;; 2. a structure: (make-square p s)
;;    where p is a posn, s a number.
;; 3. a structure: (make-rect p w h)
;;    where p is a posn, w a number and h a number

;; Final Definition: 
;; perimeter : shape  ->  number
;; to compute the perimeter of a-shape
(define (perimeter a-shape)
  (cond
    [(circle? a-shape)
     (* (* 2 (circle-radius a-shape)) pi)]
    [(square? a-shape)
     (* (square-length a-shape) 4)]
    [(rectangle? a-shape)
     (+ (* (rect-width a-shape) 2) (* (rect-height a-shape) 2))]))




;; Version 2:

;; Data Definitions:
(define-struct circle (center radius))
;; A circle is a structure:
;;          (make-circle p s)
;;    where p is a posn, s a number;

(define-struct square (nw length))
;; A square is a structure:
;;          (make-square p s)
;;    where p is a posn, s a number.

(define-struct rectangle (uc width height))
;; A rectangle is a structure:
;;          (make-rect p w h)
;;    where p is a posn, w a number and h a number

;; A shape is either
;; 1. a circle, or
;; 2. a square, or
;; 3. a rectangle.

;; Final Definitions: 
;; perimeter : shape  ->  number
;; to compute the perimeter of a-shape
(define (perimeter a-shape)
  (cond
    [(circle? a-shape)
     (perimeter-circle a-shape)]
    [(square? a-shape)
     (perimeter-square a-shape)]
    [(rect? a-shape)
     (perimeter-rectangle a-shape)]))

;; perimeter-circle : circle  ->  number
;; to compute the perimeter of a-circle
(define (perimeter-circle a-circle)
  (* (* 2 (circle-radius a-circle)) pi))

;; perimeter-square : square  ->  number
;; to compute the perimeter of a-square
(define (perimeter-square a-square)
  (* (square-length a-square) 4))

;;perimeter-rectangle : rectangle  ->  number
;; to compute the perimeter of a-square
(define (perimeter-rectangle a-shape)
  (+ (* (rect-width a-shape) 2) (* (rect-height a-shape) 2)))