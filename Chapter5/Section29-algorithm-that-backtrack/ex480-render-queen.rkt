;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname render-queen-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; constants
(define queen (local ((define t (text "Q" 16 "black"))
                      (define c (circle 10 "outline" "red")))
                (overlay/align "middle" "middle" t c)))
(define LENGTH (image-width queen))
(define S (square LENGTH "outline" "black"))


;; functions
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


; N [List-of QP] Image -> Image
; produces an image of an n by n chess board with image i placed
; according to l.

(check-expect (render-queens 5 `(,QP-1) queen)
              (place-image queen
                           (- (* 1 LENGTH) 10)
                           (- (* 2 LENGTH) 10)
                           (place-image (create-board 5)
                                        50 50
                                        (empty-scene 100 100))))
(check-expect (render-queens 6 `(,QP-1 ,QP-2) queen)
              (place-images (make-list 2 queen)
                            (list (make-posn 10 30)
                                  (make-posn 10 90))
                            (place-image (create-board 6)
                                         60 60
                                         (empty-scene 120 120))))
(check-expect (render-queens 3 '() queen)
              (place-image (create-board 3)
                           30 30
                           (empty-scene 60 60)))

(define (render-queens n l i)
  (local ((define SCENE-LEN (* n LENGTH))
          (define HALF-LEN (/ SCENE-LEN 2))
          ; Posn -> Posn
          ; produces the real position of the given pos.
          (define (create-posn pos)
            (apply make-posn
                   (map (lambda (func) (- (* (func pos) LENGTH) 10))
                        `(,posn-x ,posn-y)))))
    (place-images (make-list (length l) i)
                  (map create-posn l)
                  (place-image (create-board n)
                               HALF-LEN HALF-LEN
                               (empty-scene SCENE-LEN SCENE-LEN)))))


;; auxiliary functions

(check-expect (create-board 5)
              (apply above
                     (make-list 5 (apply beside
                                         (make-list 5 S)))))

(define (create-board n)
  (apply above
         (make-list n (apply beside
                             (make-list n S)))))
