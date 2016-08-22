;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex237-evaluate-squared) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; main functions
; Number Number -> Boolean
; is the area of a square with side x larger than c
(define (squared>? x c)
  (> (* x x) c))


;; auxiliary functions
(define (extract R l t)
  (cond [(empty? l) '()]
        [else (cond
                [(R (first l) t)
                 (cons (first l)
                       (extract R (rest l) t))]
                [else (extract R (rest l) t)])]))


;; evaluating
(squared>? 3 10) ;;; #false
(squared>? 4 10) ;;; #true
(squared>? 5 10) ;;; #true