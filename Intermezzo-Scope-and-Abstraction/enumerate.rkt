;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname enumerate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


; [List-of X] -> [List-of [X Number]]
; produces a list of same items paired with their relative index.

(check-expect (enumerate '("a" "b" "c"))
              '(("a" 0) ("b" 1) ("c" 2)))
(check-expect (enumerate '("s" 2 10))
              '(("s" 0) (2 1) (10 2)))

(define (enumerate lx)
  (for/list ([item lx]
             [index (length lx)])
    `(,item ,index)))


; [List-of X] -> [List-of [X Number]]
; produces a list of same items paired with their relative index.

(check-expect (enumerate-v2 '("a" "b" "c"))
              '(("a" 0) ("b" 1) ("c" 2)))
(check-expect (enumerate-v2 '("s" 2 10))
              '(("s" 0) (2 1) (10 2)))

(define (enumerate-v2 lx)
  (local ((define indexs (range 0 (length lx) 1)))
    (map list lx indexs)))






