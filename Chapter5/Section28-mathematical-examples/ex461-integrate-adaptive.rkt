;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname test-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define ε 0.1)

; Number -> Number
(define (constant x) 20)

; Number -> Number
(define (linear x) (* 2 x))

; Number -> Number
(define (square x) (* 3 (sqr x)))


;; functions
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b, using
; Adaptive strategy

(check-within (integrate-adaptive constant 12 22) 200 ε)
(check-within (integrate-adaptive linear 0 10) 100 ε)
(check-within (integrate-adaptive square 0 10)
              1000
              ε)

(define (integrate-adaptive f a b)
  (local ((define WIDTH (* 0.05 ε))
          (define SMALL-RECT (* WIDTH (- b a)))
          ; Number Number -> NUmber
          ; computes the given area's approximate value.
          (define (compute-area left right)
            (* 1/2
               (- right left)
               (+ (f left) (f right))))
          (define given-area (compute-area a b))
          (define two-halves (integrate-kepler f a b))
          ; [Number -> Number] Number Number -> Number
          ; calculates the area unbder f between a and b, using
          ; divide-and-conquer strategy
          (define (integrate-dc left right)
            (local ((define mid (/ (+ left right) 2)))
              (cond [(<= (- right left) WIDTH) (integrate-kepler f left right)]
                    [else (+ (integrate-adaptive f left mid)
                             (integrate-adaptive f mid right))])))
          )
    (cond [(<= (abs (- given-area two-halves))
               SMALL-RECT)
           given-area]
          [else (integrate-dc a b)])))


;; auxiliary functions
; [Number -> Number] Number Number -> Number
; produces the approximate area of the f between a and b.
; assume the (< a b) holds.

(check-within (integrate-kepler constant 12 22) 200 ε)
(check-within (integrate-kepler linear 0 10) 100 ε)
(check-within (integrate-kepler square 0 10)
              1000
              ε)

(define (integrate-kepler f a b)
  (local ((define mid (/ (+ a b) 2))
          ; Number Number -> NUmber
          ; computes the given area's approximate value.
          (define (compute-area left right)
            (* 1/2
               (- right left)
               (+ (f left) (f right)))))
    (+ (compute-area a mid)
       (compute-area mid b))))


