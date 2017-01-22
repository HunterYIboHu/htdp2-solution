;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname height-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; data definitions
(define-struct node [left right])
; A Tree is one of: 
; – '()
; – (make-node Tree Tree)


;; data examples
(define example
  (make-node (make-node '() (make-node '() '())) '()))


;; functions
; Tree -> N
; produces the height of abt.

(check-expect (height example) 3)
(check-expect (height (make-node '() '())) 1)

(define (height abt)
  (cond
    [(empty? abt) 0]
    [else (+ (max (height (node-left abt))
                  (height (node-right abt))) 1)]))


; Tree -> N
; produces the height of abt.

(check-expect (height.v2 example) 3)
(check-expect (height.v2 (make-node '() '())) 1)

(define (height.v2 abt0)
  (local (; Tree N -> N
          ; measure the height of abt
          ; accumulator a is the number of steps 
          ; it takes to reach abt from abt0
          (define (height/a abt a)
            (cond
              [(empty? abt) a]
              [else
               (max (height/a (node-left abt)
                              (add1 a))
                    (height/a (node-right abt)
                              (add1 a)))])))
    (height/a abt0 0)))


; Tree -> N
; produces the height of abt.

(check-expect (height.v3 example) 3)
(check-expect (height.v3 (make-node '() '())) 1)

(define (height.v3 abt0)
  (local (; Tree N N -> N
          ; measure the height of abt
          ; accumulator s is the number of steps
          ; it takes to reach abt from abt0
          ; accumulator m is the maximal height of the part of abt0
          ; that is to the left of abt.
          (define (h/a abt s m)
            (cond [(empty? abt) m]
                  [else
                   (local ((define new-m
                             (if (empty? (node-left abt))
                                 m
                                 (add1 m))))
                     (max (h/a (node-left abt) (add1 s) new-m)
                          (h/a (node-right abt) (add1 s) new-m)))]))
          )
    (h/a abt0 0 1)))









