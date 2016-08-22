;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex153-col-and-row) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


; Graphic constants
(define TEST (rectangle 20 40 "outline" "black"))
(define WHITE (rectangle 0 0 "outline" "white"))


; A N is one of:
; - 0
; - (add1 N)
; interpretation represents the natural numbers or counting numbers


; N Image -> Image
; produce a column of n copies of img.

(check-expect (col 3 TEST) (above TEST TEST TEST))
(check-expect (col 0 TEST) WHITE)

(define (col n img)
  (cond [(zero? n) WHITE]
        [(positive? n) (above img (col (sub1 n) img))]))


; N Image -> Image
; produce a row of n copies of img.

(check-expect (row 3 TEST) (beside TEST TEST TEST))
(check-expect (row 0 TEST) WHITE)

(define (row n img)
  (cond [(zero? n) WHITE]
        [(positive? n) (beside img (row (sub1 n) img))]))