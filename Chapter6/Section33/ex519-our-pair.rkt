;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex519-our-pair) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct cpair [count left right])
; A [MyList X] is one of:
; '()
; (make-cpair (tech "N") X [MyList X])
; accumulator the count field is the number of cpairs.


;; constructor
; data definitions, via a constructor-function
(define (our-cons f r)
  (cond [(empty? r) (make-cpair 1 f r)]
        [(cpair? r) (make-cpair (add1 (cpair-count r)) f r)]
        [else (error "our-cons: ...")]))


;; functions
; Any -> N
; how many items does l contain
(define (our-length l)
  (cond [(empty? l) 0]
        [(cpair? l) (cpair-count l)]
        [else (error "my-length: ...")]))


;; Questions
;; Q1:  Argue that our-pair takes a constant amount of time to
;; compute its result, regardless of the size of its input.
;;
;; A1: Because the function just extracts the content of 'count field,
;; this cost a constant amount of time.
;; P.S. I think our-pair means our-length ...