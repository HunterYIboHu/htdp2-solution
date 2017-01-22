;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 27.1-sierpinski-triangle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; constants
(define SMALL 10) ; a size measure in terms of pixels
(define small-triangle (triangle SMALL 'outline 'red))


;; functions
; Number -> Image
; generative creates Sierpinski Δ of size side by generating one
; for (/ side 2) and plaing one copy able two copies.

(check-expect (sierpinski SMALL) small-triangle)
(check-expect (sierpinski (* 2 SMALL))
              (above small-triangle
                     (beside small-triangle small-triangle)))

(define (sierpinski side)
  (cond [(<= side SMALL)
         (triangle side 'outline 'red)]
        [else (local ((define half-sized (sierpinski (/ side 2))))
                (above half-sized
                       (beside half-sized half-sized)))]))