;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex97-in-reach) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physical constants
(define R 10)

; Location is one of:
; - Posn
; - Number
; interpretation Posn are position on the Cartesian plane,
; Numbers are positions on either the x- or the y-axis.

(define loc-i (make-posn 5 5))
(define loc-o (make-posn 10 1))
(define loc-e (make-posn 6 8))

(define loc-po 11)
(define loc-pe 10)
(define loc-pi 5)


; in-reach
; Location -> Boolean
; determines whether the loc's distance to the origin is
; strictly less than R. If so, return #t; else return #f
; examples:
(check-expect (in-reach? loc-i) #t)
(check-expect (in-reach? loc-o) #f)
(check-expect (in-reach? loc-e) #f)

(check-expect (in-reach? loc-pi) #t)
(check-expect (in-reach? loc-po) #f)
(check-expect (in-reach? loc-pe) #f)

(define (in-reach? loc)
  (cond [(posn? loc)
         (< (sqrt (+ (sqr (posn-x loc))
                     (sqr (posn-y loc))))
            R)]
        [(number? loc)
         (< loc R)]
        [else #f]))




