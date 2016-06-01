;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex88-VPC-Struct-define) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct vcat [pos hp])
; VCat = (make-vcat Number Number)
; interpretation (make-cat p h) means the cat's x-coordinate and
; cat's happiness point.

(define vc-1 (make-vcat 45 50))


; Full cat-program
; VCat -> VCat
; consume a initial state and return the next one.
(define (cat-prog vcat)
  (big-bang vcat
            [on-tick tock]
            [on-key press-key]
            [to-draw render]))


