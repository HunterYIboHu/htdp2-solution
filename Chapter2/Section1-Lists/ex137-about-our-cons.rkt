;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex137-about-our-cons) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
  (cond [(empty? a-list) (error 'our-rest "...")]
        [(pair? a-list) (if (pair? (pair-right a-list))
                            (pair-right a-list)
                            (pair-left a-list))]
        [else (error "TypeError: not a pair type")]))


; use stepper
(our-first (our-cons "a" '()))
(our-rest (our-cons "a" '()))