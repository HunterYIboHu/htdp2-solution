;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex481-check-solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; data definitions
(define QUEENS 8)
; A QP is a structure:
;    (make-posn CI CI)
; A CI is an N in [0, QUEENS).
; interpretation (make-posn r c) denotes the square at
; the r-th row and c-th column.


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
; [List-of X] [List-of X] -> Boolean
; determines whether former contains the same items of latter,
; regardless of order.

(check-expect (set=? '(1 3 4 5) '(5 1 4 3)) #t)
(check-expect (set=? '(1 3 4 5) '(5 3 4 1 2)) #f)
(check-expect (set=? '(1 3 4 5) '(5 4 3 3)) #f)

(define (set=? former latter)
  (and (= (length former) (length latter))
       (andmap (lambda (item) (member item latter))
               former)))


; N -> [ [List-of Posn] -> Boolean ]
; produces a predicate on queen placements that determines whether a
; given placement is a solution to n queens puzzle:
; (1) the length is n;
; (2) All QP do not threaten other QP.

(check-satisfied `(,0-1 ,1-3 ,2-0 ,3-2)
                 (n-queens-solution? 4))

(define (n-queens-solution? n)
  (lambda (lop) (and (= n (length lop))
                     (andmap (lambda (pair)
                               (not (apply threatening? pair)))
                             (create-pair lop)))))


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
    (cond [(or (= f-x l-x)
               (= f-y l-y)
               (= (+ f-x l-y) (+ f-y l-x))
               (= (+ f-x f-y) (+ l-x l-y)))
           #true]
          [else #false])))


; [List-of X] -> [List-of [List-of X]]
; creates a list of all rearrangements of the items in w

(check-satisfied (arrangements '(1 2 3))
                 (check-all-items '((1 2 3)
                                    (1 3 2)
                                    (2 1 3)
                                    (2 3 1)
                                    (3 1 2)
                                    (3 2 1))))
(check-satisfied (arrangements '("A" "B"))
                 (check-all-items '(("A" "B")
                                    ("B" "A"))))

(define (arrangements w)
  (cond
    [(empty? w) '(())]
    [else
      (foldr (lambda (item others)
               (local ((define without-item
                         (arrangements (remove item w)))
                       (define add-item-to-front
                         (map (lambda (a) (cons item a))
                              without-item)))
                 (append add-item-to-front others)))
        '()
        w)]))


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


;; check functions
; [List-of [List-of X]] -> [ [List-of [List-of X]] -> Boolean ]
; produces a functions which determine whether all items on llx
; are also on the given l.

(define (check-all-items l)
  (lambda (llx) (andmap (lambda (lox) (member lox l))
                        llx)))

