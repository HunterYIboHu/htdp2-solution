;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex528-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; data definitions
(define-struct b-msg [base len angle])
; a Branch-Message is (make-b-msg Posn Number Number)
; Branch-Message is to record the infromation of a branch,
; the base is the base position of the branch,
; the len is the length of the branch,
; the angle is the angle of branch.


;; constants
(define SMALL 10)
(define MT (empty-scene 400 400))


;; data examples
(define _MT-TREE (add-line MT
                           200 0
                           200 90
                           "black"))


;; functions
; Image Number Number Number Number -> Image
; adds a fractal Savannah tree to the 's0.
; 's0 is the scene to draw the tree;
; 'x and 'y are the x-coordinate and y-coordinate of the base point;
; 'len is the length of the line;
; 'angle is the angle of the line.
; accumulator the function accumulates the s0.

(define (add-savannah s0 x y len angle)
  (local (; Image Number Number Number Number -> Image
          ; help render a savannah by the given x, y, len and angle
          (define (add-savannah/a _s0 _x _y _len _angle)
            (cond [(too-short? _len) _s0]
                  [else
                   (let* ([los1 (add-branches _s0 _x _y _len _angle)]
                          [s1 (first los1)]
                          [b-left (second los1)]
                          [b-right (third los1)]
                          [left-base (b-msg-base b-left)]
                          [right-base (b-msg-base b-right)]
                          ; Image Posn Branch-Message -> Image
                          [make-savannah
                           (λ (scene base branch)
                             (add-savannah/a scene
                                             (posn-x base)
                                             (posn-y base)
                                             (b-msg-len branch)
                                             (b-msg-angle branch)))]
                          [left-s (make-savannah s1 left-base b-left)])
                     (make-savannah left-s right-base b-right))])))
    (rotate 180 (add-savannah/a s0 x y len angle))))


;; auxiliary function
; Number -> Boolean
; is the line's length too short to be divided.

(check-expect (too-short? 5) #t)
(check-expect (too-short? 15) #f)

(define (too-short? len)
  (<= len SMALL))


; Image Number Number Number -> (List Image Branch-Message Branch-Message)
; adds an tree on the s0 at specificed position (x, y).
; the left branch's length is 2/3 of len,
; the right branch's length is 4/5 of len,
; angle is a fraction whose denominator is 360, and times pi.



(define (add-branches s0 x y len angle)
  (let* ([left-len (* len 2/3)]
         [right-len (* len 4/5)]
         [left-angle (+ angle 54/360)]
         [right-angle (- angle 72/360)]
         [left-base (make-posn/polar x y (* 1/3 len) angle)]
         [right-base (make-posn/polar x y (* 2/3 len) angle)]
         [left-end (make-posn/polar (posn-x left-base)
                                    (posn-y left-base)
                                    left-len
                                    left-angle)]
         [right-end (make-posn/polar (posn-x right-base)
                                     (posn-y right-base)
                                     right-len
                                     right-angle)]
         ; Image Posn Posn String -> Image
         [add-line/auxi (λ (scene base end color)
                          (apply add-line `(,scene ,(posn-x base)
                                                   ,(posn-y base)
                                                   ,(posn-x end)
                                                   ,(posn-y end)
                                                   ,color)))])
    (list (add-line/auxi (add-line/auxi s0 left-base left-end "green")
                         right-base right-end "red")
          (make-b-msg left-base left-len left-angle)
          (make-b-msg right-base right-len right-angle))))


; Number Number Number Number -> Posn
; produces the position of a line's end point,
; x and y are the x-coordinate and y-coordinate of the base point;
; len is the length of the given line;
; angle is a fraction whose denominator is 360, and times pi.

(define (make-posn/polar x y len angle)
  (make-posn (+ x (* len (cos (* pi angle))))
             (+ y (* len (sin (* pi angle))))))


;; test
(rotate 180 (first (add-branches _MT-TREE 200 0 90 180/360)))
(add-savannah _MT-TREE 200 0 90 180/360)

