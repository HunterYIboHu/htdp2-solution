;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9.2-empty-list-and-cons) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct pair [left right])
; A ConsPair is (make-pair Any ANy)

; A ConsOrEmpty is one of:
; - '()
; - (cons Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of all BSL lists


; Any ConsOrEmpty -> ConsOrEmpty

(define (our-cons a-value a-list)
  (cond [(empty? a-list) (make-pair a-value a-list)]
        [(pair? a-list) (make-pair a-value a-list)]
        [else (error "cons: list as second argument expected")]))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))


; ConsOrEmpty -> ConsOrEmpty
; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest "...")
      (if (pair? a-list)
          (pair-right a-list)
          (make-pair a-list '()))))


(our-first (our-cons "a" '()) )