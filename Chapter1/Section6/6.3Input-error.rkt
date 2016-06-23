;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6.3Input-error) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))


; Any -> Number
; computes the area of a disk with radius r
; if r is a number.


(define (checked-area-of-disk r)
  (cond [(number? r) (area-of-disk r)]
        [else (error "area-of-disk: number expected")]))