;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex160-roit-world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


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


(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of:
; - '()
; - (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n
; balloons must yet be thrown and the thrown balloons landed at lob
; examples:

(define ZERO (make-pair 0 '()))
(define TWO (make-pair 2 (cons (make-posn (* 3 SIZE) (* 12 SIZE))
                               (cons (make-posn (* 5 SIZE) (* 2 SIZE))
                                     '()))))
(define FIVE (make-pair 5 (cons (make-posn (* 3 SIZE) (* 12 SIZE))
                                (cons (make-posn (* 5 SIZE) (* 2 SIZE))
                                      (cons (make-posn (* 7 SIZE) (* 7 SIZE))
                                            (cons (make-posn (* 7 SIZE) (* 9 SIZE))
                                                  (cons (make-posn (* 2 SIZE)
                                                                   (* 10 SIZE))
                                                        '())))))))


; N -> Pair
(define (riot n)
  (big-bang (make-pair n '())
            [to-draw add-balloons]
            [on-key keyh]
            [on-tick throw 1]))


; Pair -> Image
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
  (cond [(empty? (pair-lob alop)) L-HALL]
        [(cons? (pair-lob alop)) (place-image BALLOON
                                              (posn-x (first (pair-lob alop)))
                                              (posn-y (first (pair-lob alop)))
                                              (add-balloons (make-pair (pair-balloon# alop)
                                                                       (rest (pair-lob alop)))))]))


; Pair KeyEvent -> Pair
; if ke is " ", then add 1 to pair-balloon# of alop and
; insert a random position into pair-lob of alop.
; else p won't change.

(check-expect (keyh ZERO "p") ZERO)
(check-random (keyh ZERO " ") (make-pair 0 (cons (make-posn (* SIZE (random ROWS))
                                                            (* SIZE (random COLS))) (pair-lob ZERO))))

(check-expect (keyh FIVE "p") FIVE)
(check-random (keyh FIVE " ") (make-pair 5 (cons (make-posn (* SIZE (random ROWS))
                                                            (* SIZE (random COLS))) (pair-lob FIVE))))

(define (keyh alop ke)
  (cond [(key=? ke " ") (make-pair (pair-balloon# alop)
                                   (cons (make-posn (* SIZE (random ROWS))
                                                    (* SIZE (random COLS)))
                                         (pair-lob alop)))]
        [else alop]))


; Pair -> Pair
; produce a random position on the scene per second when the balloon# is over 0;
; after producing a position, the balloon# of pair will sub to 0.

(check-expect (throw ZERO) ZERO)
(check-random (throw (make-pair 2 '()))
              (make-pair 1 (cons (make-posn (* SIZE (random ROWS))
                                            (* SIZE (random COLS))) '())))
(check-random (throw (make-pair 10 '()))
              (make-pair 9 (cons (make-posn (* SIZE (random ROWS))
                                            (* SIZE (random COLS))) '())))

(define (throw alop)
  (cond [(zero? (pair-balloon# alop)) alop]
        [(positive? (pair-balloon# alop))
         (make-pair (sub1 (pair-balloon# alop))
                    (cons (make-posn (* SIZE (random ROWS))
                                     (* SIZE (random COLS))) (pair-lob alop)))]))


(riot 10)
; launch the program





