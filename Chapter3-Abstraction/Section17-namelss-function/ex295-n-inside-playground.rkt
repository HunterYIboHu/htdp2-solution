;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex295-n-inside-playground) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define pos-1 (make-posn 10 20))
(define pos-2 (make-posn 1000 20))
(define pos-3 (make-posn 20 10000))
(define pos-4 (make-posn 122 250))
(define pos-5 (make-posn 100 200))


; distances in terms of pixels 
(define WIDTH 300)
(define HEIGHT 300)
 
; N -> [List-of Posn]
; generate n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))
(define (random-posns n)
  (build-list
    n
    (lambda (i)
      (make-posn (random WIDTH) (random HEIGHT)))))


; N -> [List-of Posn]
; produce a lop which contains n of pos-1.

(check-satisfied (random-posns/bad 3)
                 (n-inside-playground? 3))

(define (random-posns/bad n)
  (make-list n pos-1))


; N -> [ [List-of Posn] -> Boolean ]
; ensure the length of the given list is equal to the given count
; and all of them is in [0,WIDTH) by [0,HEIGHT)

(check-expect [(n-inside-playground? 3) `(,pos-1 ,pos-4 ,pos-5)] #true)
(check-expect [(n-inside-playground? 3) '()] #false)
(check-expect [(n-inside-playground? 1) `(,pos-1 ,pos-4 ,pos-5)] #false)
(check-expect [(n-inside-playground? 2) `(,pos-1 ,pos-2)] #false)

(define (n-inside-playground? count)
  (lambda (l)
    (and (= count (length l))
         (local (; Number Number -> Boolean
                 ; determine whether the first argument is in [0, sec)
                 (define (in-range num max)
                   (and (>= num 0)
                        (< num max))))
           (andmap (lambda (pos)
                     (and (in-range (posn-x pos) WIDTH)
                          (in-range (posn-y pos) HEIGHT))) l)))))