;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex393-union) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 393. Figure 58 presents two data definitions for finite sets.
;Design the union function for the representation of finite sets of your choice.
;It consumes two sets and produces one that contains the elements of both.
;Design intersect for the same set representation. It consumes two sets and
;produces the set of exactly those elements that occur in both.


;; data difinitions
; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s.


;; constants
(define s1 '(1 2 3 4 5 6))
(define s2 '(2 4 6 8 10))
(define s3 '(3 5 6 8 12))


;; functions
; Son.R Son.R -> Son.R
; produces one Son.R that contains the elements of both.

(check-satisfied (union s1 s2) (equal-set? '(1 2 3 4 5 6 8 10)))
(check-satisfied (union s1 s3) (equal-set? '(1 2 3 4 5 6 8 12)))
(check-expect (union s1 '()) s1)
(check-expect (union '() s1) s1)
(check-expect (union '() '()) '())

(define (union set-1 set-2)
  (cond [(empty? set-1) set-2]
        [(empty? set-2) set-1]
        [(cons? set-2)
         (local ((define head (first set-2))
                 (define tail (union set-1 (rest set-2))))
           (if (member? head set-1)
               tail
               (cons head tail)))]))


; Son.R Son.R -> Son.R
; produces one Son.R that contains the elements that occur in both.

(check-satisfied (intersect s1 s2) (equal-set? '(2 4 6)))
(check-satisfied (intersect s1 s3) (equal-set? '(3 5 6)))
(check-expect (intersect '(1 2) '(3 4)) '())
(check-expect (intersect '() s1) '())
(check-expect (intersect s1 '()) '())
(check-expect (intersect '() '()) '())

(define (intersect set-1 set-2)
  (cond [(or (empty? set-1) (empty? set-2)) '()]
        [else
         (local ((define head (first set-2))
                 (define tail (intersect set-1 (rest set-2))))
           (if (member? head set-1)
               (cons head tail)
               tail))]))


;; auxiliary functions
; Son.R -> [Son.R -> Boolean]
; return a function which determine the given set is euqals to
; items.

(check-expect ((equal-set? '(1 2)) '(1 2)) #true)
(check-expect ((equal-set? '(1 2)) '(1 2 3)) #false)

(define (equal-set? items)
  (lambda (set) (and (= (length items) (length set))
                     (andmap (lambda (x) (member? x items)) set))))



