;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex113-checked-make-vec) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct vec [x y])

; A vec is
; (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector


; Any Any -> Number
; checks that a is x and y are proper inputs for function
; make-vec
; examples:
(check-expect (checked-make-vec 10 5)
              (make-vec 10 5))
(check-error (checked-make-vec "str" 5)
             "checked-make-vec: positive number expected")

(define (checked-make-vec x y)
  (cond [(and (and (number? x) (positive? x))
              (and (number? y) (positive? y)))
         (make-vec x y)]
        [else (error "checked-make-vec: positive number expected")]))