;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex154-add-balloons) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


; Physical constants
(define COLS 18)
(define ROWS 8)
(define SIZE 10)
(define BLOCK (rectangle SIZE SIZE "outline" "black"))
(define L-HALL (place-image (row ROWS (col COLS BLOCK))
                            (/ (* ROWS SIZE) 2) (/ (* COLS SIZE) 2)
                            (empty-scene (* ROWS SIZE) (* COLS SIZE))))
(define BALLOON (circle 5 "solid" "blue"))


; List-of-posns is one of:
; - '()
; - (cons Posn List-of-posns)
; the x coordinate is between 0 and 80
; the y coordinate is between 0 and 180
; examples:

(define ZERO '())
(define TWO (cons (make-posn (* 3 SIZE) (* 12 SIZE))
                  (cons (make-posn (* 5 SIZE) (* 2 SIZE))
                        '())))
(define FIVE (cons (make-posn (* 3 SIZE) (* 12 SIZE))
                   (cons (make-posn (* 5 SIZE) (* 2 SIZE))
                         (cons (make-posn (* 7 SIZE) (* 7 SIZE))
                               (cons (make-posn (* 7 SIZE) (* 9 SIZE))
                                     (cons (make-posn (* 2 SIZE)
                                                      (* 10 SIZE))
                                           '()))))))


; List-of-posns -> Image
; add balloons to the lecture hall according to
; the position in alop.

(check-expect (add-balloons ZERO) L-HALL)
(check-expect (add-balloons TWO)
              (place-images (make-list 2 BALLOON)
                            (list (make-posn (* 3 SIZE) (* 12 SIZE))
                                  (make-posn (* 5 SIZE) (* 2 SIZE)))
                            L-HALL))
(check-expect (add-balloons FIVE)
              (place-images (make-list 5 BALLOON)
                            (list (make-posn (* 3 SIZE) (* 12 SIZE))
                                  (make-posn (* 5 SIZE) (* 2 SIZE))
                                  (make-posn (* 7 SIZE) (* 7 SIZE))
                                  (make-posn (* 7 SIZE) (* 9 SIZE))
                                  (make-posn (* 2 SIZE) (* 10 SIZE)))
                            L-HALL))

(define (add-balloons alop)
  (cond [(empty? alop) L-HALL]
        [(cons? alop) (place-image BALLOON
                                   (posn-x (first alop))
                                   (posn-y (first alop))
                                   (add-balloons (rest alop)))]))










