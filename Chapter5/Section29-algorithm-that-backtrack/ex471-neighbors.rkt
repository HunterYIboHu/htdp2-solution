;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex471-neighbors) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data definitions
; A Node is a Symbol

; A Edge is a (cons Node [List-of Node])
; interpretation represent the nodes which are neighbors of the first
; node.

; A Graph is a [List-of Edge]


;; constants
(define sample-graph
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))


;; functions
; Node Graph -> [List-of Node]
; produces the neighbors of n in g.
; if n is not a node of g, or g is empty, then signals an error.

(check-expect (neighbors 'A sample-graph) '(B E))
(check-expect (neighbors 'D sample-graph) '())
(check-error (neighbors 'P sample-graph))
(check-error (neighbors 'A '()))

(define (neighbors n g)
  (cond [(empty? g) (error "There is no node in the graph.")]
        [(not (member? n (map first g)))
         (error "The given node is not in g.")]
        [else (second (assq n g))]))

