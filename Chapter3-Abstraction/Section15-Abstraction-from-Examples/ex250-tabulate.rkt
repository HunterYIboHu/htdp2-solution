;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex250-tabulate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define DELTA 0.0001)


;; main functions
; Number [Number -> Number] -> [List-of Number]
; tabulates tan between n and 0 (incl.) in a list

(check-within (tab-tan 3) `(,(tan 3) ,(tan 2) ,(tan 1) ,(tan 0)) DELTA)
(check-within (tab-tan 0) `(,(tan 0)) DELTA)

(define (tab-tan n)
  (tabulate n tan))


; Number [Number -> Number] -> [List-of Number]
; tabulates sqr between n and 0 (incl.) in a list

(check-within (tab-sqr 3) `(,(sqr 3) ,(sqr 2) ,(sqr 1) ,(sqr 0)) DELTA)
(check-within (tab-sqr 0) `(,(sqr 0)) DELTA)

(define (tab-sqr n)
  (tabulate n sqr))


;; important functions
(define (tabulate n F)
  (cond [(= n 0) `(,(F 0))]
        [else (cons (F n) (tabulate (sub1 n) F))]))


;; auxiliary functions
; Number -> [List-of Number]
; tabulates sin between n and 0 (incl.) in a list

(check-within (tab-sin 3) `(,(sin 3) ,(sin 2) ,(sin 1) ,(sin 0)) DELTA)
(check-within (tab-sin 0) `(,(sin 0)) DELTA)

(define (tab-sin n)
  (cond [(= n 0) `(,(sin 0))]
        [else (cons (sin n) (tab-sin (sub1 n)))]))


; Number -> [List-of Number ]
; tabulates sqrt between n and 0 (incl.) in a list

(check-within (tab-sqrt 3) `(,(sqrt 3) ,(sqrt 2) ,(sqrt 1) ,(sqrt 0)) DELTA)
(check-within (tab-sqrt 1) `(,(sqrt 1) ,(sqrt 0)) DELTA)

(define (tab-sqrt n)
  (cond [(= n 0) `(,(sqrt 0))]
        [else (cons (sqrt n) (tab-sqrt (sub1 n)))]))