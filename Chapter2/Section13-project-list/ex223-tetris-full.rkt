;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex223-tetris-full) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define HEIGHT 10)
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
(define block-left-w (make-block 5 7))
(define block-right-w (make-block 3 7))

(define block-rest1 (make-block 3 10))
(define block-rest2 (make-block 4 10))
(define block-rest3 (make-block 5 10))
(define block-rest4 (make-block 4 9))
(define block-rest5 (make-block 4 8))
(define block-rest6 (make-block 4 7))
(define block-rest7 (make-block 4 6))
(define block-rest8 (make-block 4 5))
(define block-rest9 (make-block 4 4))
(define block-rest10 (make-block 4 3))
(define block-rest11 (make-block 4 2))
(define block-rest12 (make-block 4 1))

(define landscape0 (list block-rest1 block-rest2 block-rest3))
(define landscape1 (list block-rest1 block-rest2 block-rest3
                         block-rest4 block-rest5 block-rest6))
(define landscape-top (list block-rest1 block-rest2 block-rest3
                            block-rest4 block-rest5 block-rest6
                            block-rest7 block-rest8 block-rest9
                            block-rest10 block-rest11 block-rest12))

(define tetris0 (make-tetris block-droping landscape0))
(define tetris1 (make-tetris block-droping2 landscape1))
(define tetris2 (make-tetris block-left-w landscape1))
(define tetris3 (make-tetris block-right-w landscape1))
(define tetris-top (make-tetris block-droping landscape-top))


;; main functions
; Tetris -> Tetris
(define (tetris-main t)
  (big-bang t
            [on-tick drop 0.2]
            [on-key keyh]
            [to-draw tetris-render]
            [stop-when touch-top?]))


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


; Tetris -> Tetris
; produces the next state of game.The block should move down 1 SIZE if
; it don't landed on the bottom or another rest block. After 1 block
; landed, another block will appear on random position whose y should be 1.

(check-expect (drop tetris0) (make-tetris (make-block 3 2) landscape0))
(check-expect (drop tetris1) (make-tetris (make-block 4 6) landscape1))
(check-random (drop (make-tetris (make-block 4 6) landscape1))
              (make-tetris (create-block (cons (make-block 4 6) landscape1))
                           (cons (make-block 4 6) landscape1)))

(define (drop t)
  (cond [(landed? t) (make-tetris (create-block (cons (tetris-block t)
                                                      (tetris-landscape t)))
                                  (cons (tetris-block t)
                                        (tetris-landscape t)))]
        [else (make-tetris (make-block (block-x (tetris-block t))
                                       (add1 (block-y (tetris-block t))))
                           (tetris-landscape t))]))


; Tetris KeyEvent -> Tetris
; control the horizontal movement of the droping block.
; if ke is "left", then move the block left 1 SIZE unless the block
; is the left most or there are some stack of blocks stop it.
; if ke is "right", then move the bock right 1 SIZE unless the block
; is the right most or there are some stack of blocks stop it.

(check-expect (keyh tetris0 "left")
              (make-tetris (make-block 2 1) landscape0))
(check-expect (keyh tetris0 "right")
              (make-tetris (make-block 4 1) landscape0))
(check-expect (keyh tetris0 "p") tetris0)

(check-expect (keyh tetris2 "left") tetris2)
(check-expect (keyh tetris2 "right")
              (make-tetris (make-block 6 7) landscape1))
(check-expect (keyh tetris2 "p") tetris2)

(check-expect (keyh tetris3 "left")
              (make-tetris (make-block 2 7) landscape1))
(check-expect (keyh tetris3 "right") tetris3)
(check-expect (keyh tetris3 "p") tetris3)

(define (keyh t ke)
  (cond [(key=? ke "left")
         (make-tetris (move-left (tetris-block t) (tetris-landscape t))
                      (tetris-landscape t))]
        [(key=? ke "right")
         (make-tetris (move-right (tetris-block t) (tetris-landscape t))
                      (tetris-landscape t))]
        [else t]))


; Tetris -> Boolean
; determine whether one column of landscape has touch the top of canvas.

(check-expect (touch-top? tetris-top) #true)
(check-expect (touch-top? tetris0) #false)
(check-expect (touch-top? tetris1) #false)

(define (touch-top? t)
  (touch/auxi (tetris-landscape t)))


;; auxiliary functions
; Block Image -> Image
; render a block onto a specific image.

(check-expect (block-render block-droping SCENE)
              (place-image BLOCK 25 5 SCENE))
(check-expect (block-render block-rest2 SCENE)
              (place-image BLOCK 35 95 SCENE))

(define (block-render b img)
  (place-image BLOCK
               (- (* SIZE (block-x b)) MID-S)
               (- (* SIZE (block-y b)) MID-S)
               img))


; Landscape -> Block
; create a new block whose position is different from other blocks

(check-random (create-block landscape0) (checked-create-block landscape0
                                                              (make-block (+ (random SIZE) 1) 1)))

(define (create-block l)
  (checked-create-block l
                        (make-block (add1 (random SIZE)) 1)))


; Tetris Block -> Block
; determine whether the block is different from the given landscape
; if it is, then return it; otherwise produce another block.

(check-expect (checked-create-block landscape0 block-droping)
              block-droping)
(check-random (checked-create-block (cons block-droping2 landscape0) block-droping2)
              (create-block (cons block-droping2 landscape0)))

(define (checked-create-block l b)
  (if (member? b l)
      (create-block l)
      b))


; Tetris -> Boolean
; determine whether the droping block is landed on the bottom or the rest ones.

(check-expect (landed? tetris0) #false)
(check-expect (landed? tetris1) #false)
(check-expect (landed? (make-tetris (make-block 4 6) landscape1)) #true)
(check-expect (landed? (make-tetris (make-block 9 10) landscape0)) #true)

(define (landed? t)
  (cond [(>= (block-y (tetris-block t)) HEIGHT) #true] ; check if block landed on the bottom
        [(member? (make-block (block-x (tetris-block t))
                              (add1 (block-y (tetris-block t))))
                  (tetris-landscape t)) #true] ; check if block landed on the rest ones
        [else #false]))


; Block Landscape -> Block
; determine whether to move the given b left 1 SIZE.
; if given b is not a member of given l and the (block-x b) is not 0,
; return the moved block; otherwise return the b.

(check-expect (move-left block-droping landscape0)
              (make-block 2 1))
(check-expect (move-left (make-block 5 7) landscape1)
              (make-block 5 7))

(define (move-left b l)
  (if (or (member? (make-block (sub1 (block-x b))
                               (block-y b))
                   l)
          (= (block-x b) 1))
      b
      (make-block (sub1 (block-x b))
                  (block-y b))))


; Block Landscape -> Block
; determine whether to move the given b right 1 SIZE.
; if given b is not a member of given l and the (block-x b) is not WIDTH,
; return the moved block; otherwise return the b.

(check-expect (move-right block-droping landscape0)
              (make-block 4 1))
(check-expect (move-right (make-block 3 7) landscape1)
              (make-block 3 7))

(define (move-right b l)
  (if (or (member? (make-block (add1 (block-x b))
                               (block-y b))
                   l)
          (= (block-x b) WIDTH))
      b
      (make-block (add1 (block-x b))
                  (block-y b))))


; Landscape -> Boolean
; determine whether one of the landscape's y is 1.
; if it is, return #true, else return #false.

(check-expect (touch/auxi landscape0) #false)
(check-expect (touch/auxi landscape1) #false)
(check-expect (touch/auxi landscape-top) #true)

(define (touch/auxi l)
  (cond [(empty? l) #false]
        [else (or (= 1 (block-y (first l)))
                  (touch/auxi (rest l)))]))


;; launch programs
(tetris-main (make-tetris (make-block (add1 (random WIDTH))
                                      1)
                          '()))
