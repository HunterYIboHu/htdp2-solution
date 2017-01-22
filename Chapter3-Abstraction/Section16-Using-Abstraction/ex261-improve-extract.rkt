;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex261-improve-extract) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; definitions
(define-struct ir
  [name price])

(define ir-1 (make-ir "Ano" 123))
(define ir-2 (make-ir "Boo" 34324))
(define ir-3 (make-ir "Smath" 2342123))
(define ir-4 (make-ir "Sojt" 0.9873))
(define ir-5 (make-ir "math" 678490))
(define ir-6 (make-ir "Hua" 0.5))


; An IR is a structure:
;   (make-IR String Number)
; An Inventory is one of: 
; – '()
; – (cons IR Inventory)

(define inv-1 `(,ir-1 ,ir-2 ,ir-3 ,ir-4 ,ir-5 ,ir-6))
(define inv-2 `(,ir-2 ,ir-1 ,ir-4 ,ir-5))


;; functions
; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar

(check-expect (extract1 inv-1) `(,ir-4 ,ir-6))
(check-expect (extract1 inv-2) `(,ir-4))

(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (cond
       [(<= (ir-price (first an-inv)) 1.0)
        (cons (first an-inv) (extract1 (rest an-inv)))]
       [else (extract1 (rest an-inv))])]))


; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar

(check-expect (extract2 inv-1) `(,ir-4 ,ir-6))
(check-expect (extract2 inv-2) `(,ir-4))

(define (extract2 an-inv)
  (cond [(empty? an-inv) '()]
        [else (local ((define all-<-1 (extract2 (rest an-inv))))
                (cond [(<= (ir-price (first an-inv)) 1.0)
                       (cons (first an-inv) all-<-1)]
                      [else all-<-1]))]))


;; Questions
;; Q: Does this help increase the speed at which the function computes its result?
;; A: I prefer the effection is just a bit improved, for the preformence don't find any significant up.