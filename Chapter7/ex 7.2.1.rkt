;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |ex 7.2.1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct animal (cate intelligence legs space))

;; Animal is (make-animal Category Intelligence Legs Number)
;; an animal with its category, its intelligence (can be false), the number of its legs (can be false)
;; and the space it needs in case of transport

;; Intelligence is one of:
;; - Number
;; - false

;; Legs is one of:
;; - Natural
;; - false

;; Category is one of:
;; - "spider"
;; - "elephant"
;; - "monkey"

(define S1 (make-animal "spider" false 8 5))
(define S2 (make-animal "spider" false 6 5))
(define M1 (make-animal "monkey" 50 false 10))
(define M2 (make-animal "monkey" 80 false 10))
(define E1 (make-animal "elephant" false false 25))
(define E2 (make-animal "elephant" false false 40))

#;
(define (fn-for-animal a)
  (cond [(string=? (animal-cate a) "spider") (... (animal-legs a)
                                    (animal-space a))]
        [(string=? (animal-cate a) "monkey") (... (animal-intelligence a)
                                    (animal-space a))]
        [else
         (... (animal-space a))]))

(define (fits? a v)
  (cond [(string=? (animal-cate a) "spider") (> v (animal-space a))]
        [(string=? (animal-cate a) "monkey") (> v (animal-space a))]
        [else
         (> v (animal-space a))]))

; test
(fits? S1 15)
(fits? S2 3)