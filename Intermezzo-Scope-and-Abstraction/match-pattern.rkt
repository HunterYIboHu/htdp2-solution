;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname match-pattern) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


;; data difinitions
; A [Non-empty-list X] is one of: 
; – (cons X '())
; – (cons X [Non-empty-list X])


(define-struct layer [color doll])
; An RD (short for Russian doll) is one of: 
; – "string"
; – (make-layer String RD)


;; functions
; [Non-empty-list X] -> X
; extract the last item of the given l

(check-expect (last-item '(a b c)) 'c)
(check-error (last-item '()))

(define (last-item l)
  (match l
    [(cons last '()) last]
    [(cons fst rst) (last-item rst)]))


; RD -> Number
; compute the number of layers of given rd.

(check-expect (depth "red") 1)
(check-expect (depth (make-layer "yellow" (make-layer "green" "red"))) 3)

(define (depth rd)
  (match rd
    [(? string?) 1]
    [(layer c d) (add1 (depth d))]))


; [List-of Posn] Number -> [List-of Posn]
; moves each object right by delta-x pixels

(check-expect (move-right `(,(make-posn 1 1) ,(make-posn 10 14)) 3)
              `(,(make-posn 4 1) ,(make-posn 13 14)))

(define (move-right l delta-x)
  (match l
    [(? empty?) '()]
    [(cons (posn x y) rst)
     (cons (make-posn (+ x delta-x) y)
           (move-right rst delta-x))]))
;; ! there is repeated. can use abstraction like map to simpfy it.



(check-expect (move-right-v2 `(,(make-posn 1 1) ,(make-posn 10 14)) 3)
              `(,(make-posn 4 1) ,(make-posn 13 14)))

(define (move-right-v2 l delta-x)
  (map (lambda (p)
         (match p
           [(posn x y) (make-posn (+ x delta-x) y)]))
       l))

