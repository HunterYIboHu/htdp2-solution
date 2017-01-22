;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex392-simplify-tree-pick) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct branch [left right])
 
; A TOS is one of:
; – Symbol
; – (make-branch TOS TOS)
 
; A Direction is one of:
; – 'left
; – 'right
 
; A list of Directions is also called a path.


;; constants
(define PATH-ERROR "There can't find satisfied symbol in the given path.")

(define b1 'blue)
(define b2 'green)
(define b3 'red)
(define b4 'yellow)

(define tos1 (make-branch b1 b2))
(define tos2 (make-branch b3 b4))
(define tos3 (make-branch tos1 tos2))
(define tos4 (make-branch tos3 b4))

(define lod1 '(left))
(define lod2 '(left left left))
(define lod3 '(left right left))


;; functions
; TOS [List-of Direction] -> TOS
; produces the corresponding result in tos by the path;
; otherwise signals an error.

(check-expect (tree-pick b1 '()) b1)
(check-expect (tree-pick tos1 lod1) b1)
(check-expect (tree-pick tos4 lod2) b1)
(check-expect (tree-pick tos4 lod1) tos3)

(check-error (tree-pick tos4 '(right left left)))
(check-error (tree-pick b1 '(left)))

(define (tree-pick tos path)
  (cond [(empty? path) tos]
        [(symbol? tos) (error PATH-ERROR)]
        [else (tree-pick (if (symbol=? 'left (first path))
                             (branch-left tos)
                             (branch-right tos))
                         (rest path))]))

