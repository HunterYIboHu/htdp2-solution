;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname cross-and-arrangements) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


; [X Y] [List-of X] [List-of Y] -> [List-of [List X Y]]
; generate all pairs of items from l1 and l2

(check-expect (cross '(a b c) '(1 2))
              '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))
(check-satisfied (cross '(1 2 3) '("a" "b"))
                 (lambda (c) (= (length c) 6)))

(define (cross l1 l2)
  (for*/list ([item-1 l1]
              [item-2 l2])
    `(,item-1 ,item-2)))


; [List-of X] -> [List-of [List-of X]]
; creates a list of all rearrangements of the items in w.

(check-satisfied (arrangements (explode "rat"))
                 all-words-from-rat?)

(define (arrangements w)
  (cond [(empty? w) '(())] ; the result is a lol. And the for*/list use foldr and
                           ; append to connect items.
        [else (for*/list ([item w]
                          [arrangement-without-item
                           (arrangements (remove item w))])
                (cons item arrangement-without-item))]))


; [List-of X] -> Boolean 
(define (all-words-from-rat? w)
  (and (member? (explode "rat") w)
       (member? (explode "art") w)
       (member? (explode "tar") w)))