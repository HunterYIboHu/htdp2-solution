;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex493-reform-find-path-inex472) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data definitions
; A Node is a Symbol

; A Edge is a (cons Node [List-of Node])
; interpretation represent the nodes which are neighbors of the first
; node.

; A Graph is a [List-of Edge]

; A Path is a [List-of Node]
; interpretation The list of nodes specifies a sequence
; of immediate neighbors that leads from the first
; Node on the list to the last one.


;; constants
(define sample-graph
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))
(define cyclic-graph
  '((A (B E))
    (B (E F))
    (C (B D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))


;; functions
; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false.

(check-expect (find-path 'C 'D sample-graph)
              '(C D))
(check-member-of (find-path 'E 'D sample-graph)
                 '(E F D) '(E C D))
(check-expect (find-path 'C 'G sample-graph)
              #false)
(check-expect (find-path 'A 'G sample-graph)
              '(A B E F G))
(check-expect (find-path 'B 'C cyclic-graph)
              '(B E C))
(check-expect (find-path 'B 'F cyclic-graph)
              '(B E F))

(define (find-path origination destination G)
  (find-path/a origination destination G '()))


; Node Node Graph [List-of Node] -> [Maybe Path]
; add an accumulator to the function. and the initial part is done by find-path.

(define (find-path/a origination destination G seen)
  (cond [(symbol=? origination destination) (list destination)]
        [(member? origination seen) #f]
        [else (local ((define new-seen (cons origination seen))
                      (define next (neighbors origination G))
                      (define candidate
                        (find-path/list/a next destination G new-seen)))
                (cond [(boolean? candidate) #false]
                      [else (cons origination candidate)]))]))


;; auxiliary functions
; [List-of Node] Node Graph -> [Maybe Path]
; finds a path from some node on lo-originations to destination;
; otherwise, it produces #false.

(check-expect (find-path/list/a '(D) 'D sample-graph '(C))
              '(D))
(check-expect (find-path/list/a '(E F) 'F cyclic-graph '(B))
              '(E F))

(define (find-path/list/a lo-Os D G seen)
  (cond [(empty? lo-Os) #false]
        [else (local ((define new-seen (cons (first lo-Os) seen))
                      (define candidate
                        (find-path/a (first lo-Os) D G seen)))
                (cond [(boolean? candidate)
                       (find-path/list/a (rest lo-Os) D G new-seen)]
                      [else candidate]))]))


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