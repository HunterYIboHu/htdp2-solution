;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex220-tetris-render) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; constant functions
; Image List-of-posns List-of-posns
; add lines onto the given image, the first list is the position
; where line starting from, the second list is the position where line
; going to.

(check-expect (add-lines MT
                         (list (make-posn 0 10))
                         (list (make-posn 100 10)))
              (add-line MT 0 10 100 10 "black"))
(check-expect (add-lines MT
                         (list (make-posn 0 10)
                               (make-posn 10 20))
                         (list (make-posn 100 10)
                               (make-posn 100 20)))
              (add-line (add-line MT 0 10 100 10 "black")
                        10 20 100 20 "black"))

(define (add-lines img loa lob)
  (cond [(and (empty? loa) (empty? lob)) img]
        [else (add-line (add-lines img (rest loa) (rest lob))
                        (posn-x (first loa)) (posn-y (first loa))
                        (posn-x (first lob)) (posn-y (first lob))
                        "black")]))


; Number Number List-of-number -> List-of-posns
; produces a list of posns that are two position pairs
; the first position of pair has the same x-coordinate, but the
; y-coordinate is ratio multiply with a constant.
; the second position of pair has the same y-coordinate, but the
; x-coordinate is ratio multiply with a constant.

(check-expect (make-list-p 0 0 (list 1))
              (list (make-posn 0 10) (make-posn 10 0)))
(check-expect (make-list-p 100 100 (list 1 2))
              (list (make-posn 100 10)
                    (make-posn 10 100)
                    (make-posn 100 20)
                    (make-posn 20 100)))


(define (make-list-p x y ratio)
  (cond [(empty? ratio) '()]
        [else (cons (make-posn x (* 10 (first ratio)))
                    (cons (make-posn (* 10 (first ratio)) y)
                          (make-list-p x y (rest ratio))))]))


;; physical constants
(define WIDTH 10) ; # of block, horizontally
(define SIZE 10) ; blocks are squares
(define SCENE-SIZE (* WIDTH SIZE))
(define MID-S (/ SIZE 2))


(define BLOCK ; red squares with black rims
  (overlay (square (- SIZE 1) "solid" "red")
           (square SIZE "outline" "black")))
(define MT (empty-scene SCENE-SIZE SCENE-SIZE))
(define SCENE (add-lines MT
                         (make-list-p 0 0 (range 1 10 1))
                         (make-list-p 100 100 (range 1 10 1))))


;; data difinitions
(define-struct tetris [block landscape])
(define-struct block [x y])

; A Tetris is a structure
;    (make-tetris Block Landscape)
; A Landscape is one of:
; - '()
; - (cons Block Landscape)
; Block is a structure:
;    (make-block N N)

; interpretations
; (make-block x y) depicts a block whose left
; corner is (* x SIZE) pixels from the left and (* y SIZE) pixels from the top
; (make-tetris b0 (list b1 b2 ...)) means b0 is the dropping block,
; while b1, b2, and ... are resting.


;; struct constants
(define block-droping (make-block 3 1))
(define block-droping2 (make-block 4 5))
(define block-rest1 (make-block 3 10))
(define block-rest2 (make-block 4 10))
(define block-rest3 (make-block 5 10))
(define block-rest4 (make-block 4 9))
(define block-rest5 (make-block 4 8))
(define block-rest6 (make-block 4 7))

(define landscape0 (list block-rest1 block-rest2 block-rest3))
(define landscape1 (list block-rest1 block-rest2 block-rest3
                         block-rest4 block-rest5 block-rest6))

(define tetris0 (make-tetris block-droping landscape0))
(define tetris1 (make-tetris block-droping2 landscape1))


;; main functions
; Tetris -> Tetris
;(define (tetris-main t)
;  (big-bang t
;            [on-tick drop]
;            [on-key keyh]
;            [to-draw tetris-render]))


;; important functions
; Tetris -> Image
; render a scene of gamestate

(check-expect (tetris-render tetris0)
              (place-images (make-list 4 BLOCK)
                            (list (make-posn 25 5)
                                  (make-posn 25 95)
                                  (make-posn 35 95)
                                  (make-posn 45 95))
                            SCENE))
(check-expect (tetris-render tetris1)
              (place-images (make-list 7 BLOCK)
                            (list (make-posn 35 45)
                                  (make-posn 25 95)
                                  (make-posn 35 95)
                                  (make-posn 45 95)
                                  (make-posn 35 85)
                                  (make-posn 35 75)
                                  (make-posn 35 65))
                            SCENE))

(define (tetris-render t)
  (cond [(empty? (tetris-landscape t)) (block-render (tetris-block t) SCENE)]
        [else (block-render (first (tetris-landscape t))
                            (tetris-render (make-tetris (tetris-block t)
                                                        (rest (tetris-landscape t)))))]))


;; auxiliary functions
; Block Image -> Image
; render a block onto a specific image.

(check-expect (block-render block-droping SCENE)
              (place-image BLOCK 25 5 SCENE))
(check-expect (block-render block-rest2 SCENE)
              (place-image BLOCK 35 95 SCENE))

(define (block-render b img)
  (place-image BLOCK
               (- (* SIZE (block-x b)) 5)
               (- (* SIZE (block-y b)) 5)
               img))









