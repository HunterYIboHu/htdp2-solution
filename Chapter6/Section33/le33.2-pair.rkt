;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname le33.2-pair) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct pair [left right])
; ConsOrEmpty is one of:
; - '()
; - (make-pair Any ConsOrEmpty)

; Any ConOrEmpty -> ConsOrEmpty
; produces a pair by make a-value as the left part,
; and a-list as the right part.

(check-expect (our-cons 1 '()) (make-pair 1 '()))
(check-expect (our-cons 2 p2)
              (make-pair 2 (make-pair 1 '())))
(check-error (our-cons 2 '(1)))

(define (our-cons a-value a-list)
  (cond [(empty? a-list) (make-pair a-value a-list)]
        [(pair? a-list) (make-pair a-value a-list)]
        [else (error "our-cons: ...")]))


;; data examples
(define p1 '())
(define p2 (our-cons 1 '()))
(define p3 (our-cons 1 (our-cons 2 (our-cons 3 '()))))


; ConsOrEmpty -> Any
; extracts the left part of the given pair.

(check-expect (our-first p2) 1)
(check-expect (our-first p3) 1)
(check-error (our-first '()))

(define (our-first mimicked-list)
  (if (empty? mimicked-list)
      (error "our-first: ...")
      (pair-left mimicked-list)))


; ConsOrEmpty -> ConsOrEmpty
; extracts the right part of the given pair.

(check-expect (our-rest p2) '())
(check-expect (our-rest p3)
              (our-cons 2 (our-cons 3 '())))
(check-error (our-rest '()))

(define (our-rest mimicked-list)
  (if (empty? mimicked-list)
      (error "our-rest: ...")
      (pair-right mimicked-list)))

