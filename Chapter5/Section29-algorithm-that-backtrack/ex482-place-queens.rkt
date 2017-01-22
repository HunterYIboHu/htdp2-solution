;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname place-queens-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; data definitions
(define QUEENS 8)
; A QP is a structure:
;    (make-posn CI CI)
; A CI is an N in [0, QUEENS).
; interpretation (make-posn r c) denotes the square at
; the r-th row and c-th column.

(define-struct board [unused used len])
; A Board is (make-board [List-of Posn] [List-of Posn] N)


;; data examples
(define QP-1 (make-posn 1 2))
(define QP-2 (make-posn 1 5))
(define QP-3 (make-posn 5 2))
(define QP-4 (make-posn 2 3))
(define QP-5 (make-posn 2 1))

(define 0-1 (make-posn 0 1))
(define 1-3 (make-posn 1 3))
(define 2-0 (make-posn 2 0))
(define 3-2 (make-posn 3 2))


;; constants
(define queen (local ((define t (text "Q" 16 "black"))
                      (define c (circle 10 "outline" "red")))
                (overlay/align "middle" "middle" t c)))
(define LENGTH (image-width queen))
(define S (square LENGTH "outline" "black"))


;; functions
; N -> [Maybe [List-of QP]]
; find a solution to the n queens problem 
 
(check-satisfied (n-queens 4)
                 (n-queens-solution? 4))
(check-satisfied (n-queens 5)
                 (n-queens-solution? 5))
(check-expect (n-queens 3) #f)
(check-expect (n-queens 2) #f)
(check-expect (n-queens 1) `(,(make-posn 0 0)))
 
(define (n-queens n)
  (place-queens (board0 n) n))


; Board N -> [Maybe [List-of QP]]
; places n queens on board; otherwise, returns #false.

(check-satisfied (place-queens (board0 4) 4)
                 (n-queens-solution? 4))
(check-satisfied (place-queens (board0 5) 5)
                 (n-queens-solution? 5))
(check-expect (place-queens (board0 3) 3) #f)
(check-expect (place-queens (board0 1) 1)
              `(,(make-posn 0 0)))

(define (place-queens a-board n)
  (local ((define initial-pos (first (board-unused a-board)))
          (define max-row (sub1 n))
          ; Board -> Board
          ; produces a new board with the first board-used
          ; moves to the board-unused.
          (define (front-board b)
            (local ((define used (board-used b)))
              (make-board (cons (first used)
                                (board-unused b))
                          (rest used)
                          (board-len b))))
          ; Board N -> [List-of QP]
          ; produces the n'th row's unused position, remove
          ; all unsafe-spots.
          (define (make-row b current-row)
            (filter (lambda (pos) (= current-row (posn-y pos)))
                    (find-open-spots b)))

          ; Board N [List-of QP] QP-> [Maybe [List-of QP]]
          ; using backtrack to find the right QP, otherwise produces #false.
          (define (helper b row-num row pos)
            (if (member? pos row)
                (local ((define new-b (add-queen b pos))
                        (define next-row (add1 row-num)))
                  (cond [(= max-row row-num) (board-used new-b)]
                        [else (helper new-b
                                      next-row
                                      (make-row new-b next-row)
                                      (make-posn 0
                                                 next-row))]))
                (cond [(and (< 0 row-num)
                            (> max-row (posn-x pos))); not the last column, not the first row.
                       (helper b
                               row-num
                               row
                               (make-posn (add1 (posn-x pos))
                                          row-num))]
                      [else ; the last column, but not the first row.
                       (if (empty? (board-used b)) ; the first row, the last colunm.
                           #f 
                           (local ((define old-b
                                     (front-board b))
                                   (define front-pos
                                     (first (board-used b))))
                             (helper old-b
                                     (sub1 row-num)
                                     (make-row old-b (sub1 row-num))
                                     (make-posn
                                      (add1 (posn-x front-pos))
                                      (sub1 row-num)))))])))
          )
    (helper a-board 0 (make-row a-board 0) initial-pos)))


;; auxiliary functions
; N -> Board
; create the initial n by n board.

(check-expect (board0 2)
              (make-board (map (lambda (pair) (apply make-posn pair))
                               '((0 0)
                                 (0 1)
                                 (1 0)
                                 (1 1)))
                          '()
                          2))
(check-expect (board0 1)
              (make-board `(,(make-posn 0 0))
                          '()
                          1))

(define (board0 n)
  (make-board (map (lambda (pair) (apply make-posn pair))
                   (create-pair/r (build-list n identity)))
              '()
              n))


; Board QP -> Board
; places a queen at qp on a-board.

(check-expect (add-queen (board0 2) (make-posn 0 0))
              (make-board `(,(make-posn 0 1)
                            ,(make-posn 1 0)
                            ,(make-posn 1 1))
                          `(,(make-posn 0 0))
                          2))
(check-expect (add-queen (make-board `(,(make-posn 0 1)
                                       ,(make-posn 1 0)
                                       ,(make-posn 1 1))
                                     `(,(make-posn 0 0))
                                     2)
                         (make-posn 1 1))
              (make-board `(,(make-posn 0 1)
                            ,(make-posn 1 0))
                          `(,(make-posn 1 1)
                            ,(make-posn 0 0))
                          2))

(define (add-queen a-board qp)
  (make-board (remove qp (board-unused a-board))
              (cons qp (board-used a-board))
              (board-len a-board)))


; Board -> [List-of QP]
; finds spots where it is still safe to place a queen.

(check-expect (find-open-spots (add-queen (board0 2)
                                          (make-posn 0 0)))
              '())
(check-expect (find-open-spots (add-queen (board0 3)
                                         (make-posn 1 1)))
              '())
(check-satisfied (find-open-spots (add-queen (board0 3)
                                            (make-posn 0 0)))
                 (check-all-items `(,(make-posn 1 2)
                                    ,(make-posn 2 1))))

(define (find-open-spots a-board)
  (filter (lambda (p) (andmap (lambda (used)
                                (not (threatening? used p)))
                              (board-used a-board)))
          (board-unused a-board)))


; QP QP -> Boolean
; determine whether former will threaten the latter.
; threaten means :
; (1) the same x-coordinate
; (2) the same y-coordinate
; (3) the former's x-coordinate + the latter's y-coordinate equals
; the latter's x-coordinate + the former's y-coordinate.
; (4) the former's x plus y equals the latter's x plus y

(check-expect (threatening? QP-1 QP-2) #t)
(check-expect (threatening? QP-1 QP-3) #t)
(check-expect (threatening? QP-1 QP-4) #t)
(check-expect (threatening? QP-1 QP-5) #t)
(check-expect (threatening? QP-2 QP-3) #f)
(check-expect (threatening? QP-3 QP-4) #f)

(define (threatening? former latter)
  (local ((define f-x (posn-x former))
          (define f-y (posn-y former))
          (define l-x (posn-x latter))
          (define l-y (posn-y latter)))
    (or (= f-x l-x)
        (= f-y l-y)
        (= (+ f-x l-y) (+ f-y l-x))
        (= (+ f-x f-y) (+ l-x l-y)))))


; [List-of X] -> [List-of (list X X)]
; produces the pairs do not repeat itself.

(check-satisfied (create-pair '(1 2))
                 (check-all-items '((1 2))))
(check-satisfied (create-pair '("A" "B" "C"))
                 (check-all-items '(("A" "B")
                                    ("A" "C")
                                    ("B" "C"))))

(define (create-pair l)
  (cond [(empty? l) '()]
        [else (append (map (lambda (item) (list (first l) item))
                           (rest l))
                      (create-pair (rest l)))]))


; [List-of X] -> [List-of (list X X)]
; produces a list of pair, which could repeat items.

(check-satisfied (create-pair/r '(1 2 3))
                 (check-all-items (list
                                   (list 1 1)
                                   (list 1 2)
                                   (list 1 3)
                                   (list 2 1)
                                   (list 2 2)
                                   (list 2 3)
                                   (list 3 1)
                                   (list 3 2)
                                   (list 3 3))))

(define (create-pair/r lox)
  (foldr append '()
         (map (lambda (item)
                (map (lambda (another)
                       (list item another))
                     lox))
              lox)))


;; check functions
; [List-of [List-of X]] -> [ [List-of [List-of X]] -> Boolean ]
; produces a functions which determine whether all items on llx
; are also on the given l.

(define (check-all-items l)
  (lambda (llx) (and (= (length l) (length llx))
                     (andmap (lambda (lox) (member lox l))
                             llx))))


; N -> [ [List-of Posn] -> Boolean ]
; produces a predicate on queen placements that determines whether a
; given placement is a solution to n queens puzzle:
; (1) the length is n;
; (2) All QP do not threaten other QP.

(check-satisfied `(,0-1 ,1-3 ,2-0 ,3-2)
                 (n-queens-solution? 4))
(check-expect [(n-queens-solution? 1) `(,(make-posn 1 1))] #f)

(define (n-queens-solution? n)
  (local ((define usable (map (lambda (pair) (apply make-posn pair))
                              (create-pair/r (range 0 n 1)))))
    (lambda (lop) (and (= n (length lop))
                       (andmap (lambda (pos) (member? pos usable))
                               lop)
                       (andmap (lambda (pair)
                                 (not (apply threatening? pair)))
                               (create-pair lop))))))

