;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex252-fold2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; graphic constants
(define emt (empty-scene 100 100))
(define dot (circle 3 "solid" "red"))


;; abstract functions

(check-expect (fold2 '(1 2 3) 1 *) (product '(1 2 3)))
(check-expect (fold2 `(,(make-posn 10 10) ,(make-posn 0 100)) emt place-dot)
              (image* `(,(make-posn 10 10) ,(make-posn 0 100))))

(define (fold2 l default F)
  (cond [(empty? l) default]
        [else (F (car l) (fold2 (cdr l) default F))]))


;; similar functions
; [List-of Number] -> Number
; computes the product of the numbers on l

(check-expect (product '(1 2 3)) 6)
(check-expect (product '(10 5 2)) 100)
(check-expect (product '()) 1)

(define (product l)
  (cond [(empty? l) 1]
        [else (* (car l) (product (cdr l)))]))

; [List-of Posn] -> Image

(check-expect (image* `(,(make-posn 10 10) ,(make-posn 0 100)))
              (place-images (make-list 2 dot)
                            `(,(make-posn 10 10) ,(make-posn 0 100))
                            emt))
(check-expect (image* `(,(make-posn 10 10)))
              (place-image dot 10 10 emt))

(define (image* l)
  (cond [(empty? l) emt]
        [else (place-dot (car l) (image* (cdr l)))]))


;; auxiliary functions
; Posn Image -> Image

(check-expect (place-dot (make-posn 10 10) emt)
              (place-image dot 10 10 emt))
(check-expect (place-dot (make-posn 0 100) emt)
              (place-image dot 0 100 emt))

(define (place-dot p img)
  (place-image dot
               (posn-x p) (posn-y p)
               img))






