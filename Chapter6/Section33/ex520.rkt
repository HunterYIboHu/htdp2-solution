;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex520) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;; Q1: Is it acceptable to impose the extra cost on cons for all programs to turn length into a constant-time function?
;; A1: No. Because the use of cons is more frequent than the function
;; to compute its length.