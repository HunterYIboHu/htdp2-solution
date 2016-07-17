;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 10-list-design-recipe) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; A List-of-strings is one of
;; -- '()
;; -- (cons String List-of-strings)
;; examples

; by the first clause
'()

; by the second clause and the preceding example
(cons "a" '())

; again by the second clause and the preceding example
(cons "b" (cons "a" '()))


; List-of-strings -> Number
; count how many strings alos contains
; examples:

(check-expect (how-many '()) 0)
(check-expect (how-many (cons "a" '())) 1)
(check-expect (how-many (cons "b" (cons "a" '()))) 2)

(define (how-many alos)
  (cond [(empty? alos) 0]
        [else
         (+ (how-many (rest alos)) 1)]))


