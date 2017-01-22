;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex309-words-on-line) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


;; constants
(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
 
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))


; [List-of [List-of String]] -> [List-of Number]
; determines the number of words on each line 

(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1) '(2 0))

(define (words-on-line lls)
  (match lls
    ['() '()]
    [(cons fst rst)
     (cons (length fst) (words-on-line rst))]))


; [List-of [List-of String]] -> [List-of Number]
; determines the number of words on each line 

(check-expect (words-on-line-v2 lls0) '())
(check-expect (words-on-line-v2 lls1) '(2 0))

(define (words-on-line-v2 lls)
  (map (lambda (line) (length line)) lls))