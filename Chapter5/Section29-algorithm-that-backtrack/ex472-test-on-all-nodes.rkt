;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex472-test-on-all-nodes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; functions
; Graph -> Boolean
; determine whether there is a path between any pair of path.

(check-expect (test-on-all-nodes sample-graph) #f)

(define (test-on-all-nodes G)
  (andmap (lambda (pair)
            (if (boolean? (apply find-path (append pair (list G))))
                #false
                #true))
          (create-pair (extract-nodes G))))


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

(define (find-path origination destination G)
  (cond [(symbol=? origination destination) (list destination)]
        [else (local ((define next (neighbors origination G))
                      (define candidate
                        (find-path/list next destination G)))
                (cond [(boolean? candidate) #false]
                      [else (cons origination candidate)]))]))


;; auxiliary functions
; [List-of Node] Node Graph -> [Maybe Path]
; finds a path from some node on lo-originations to destination;
; otherwise, it produces #false.

(check-expect (find-path/list '(D) 'D sample-graph)
              '(D))
(check-expect (find-path/list '(C F) 'D sample-graph)
              '(C D))
(check-expect (find-path/list '(D) 'G sample-graph)
              #false)

(define (find-path/list lo-Os D G)
  (cond [(empty? lo-Os) #false]
        [else (local ((define candidate
                        (find-path (first lo-Os) D G)))
                (cond [(boolean? candidate)
                       (find-path/list (rest lo-Os) D G)]
                      [else candidate]))]))


; [List-of Node] -> [List-of (list Node Node)]
; produces all pairs which are created from given lon.

(check-expect (create-pair '(A B C D E F G))
              '((A B) (A C) (A D) (A E) (A F) (A G)
                      (B A) (B C) (B D) (B E) (B F) (B G)
                      (C A) (C B) (C D) (C E) (C F) (C G)
                      (D A) (D B) (D C) (D E) (D F) (D G)
                      (E A) (E B) (E C) (E D) (E F) (E G)
                      (F A) (F B) (F C) (F D) (F E) (F G)
                      (G A) (G B) (G C) (G D) (G E) (G F)))

(define (create-pair lon)
  (local (; Node [List-of Node] -> [List-of (list Node Node)]
          ; produces all pairs whose first item is n and the second
          ; item is the items of l which is not n.
          (define (create-pair-for-one n l)
            (map (lambda (next) (list n next)) (remove-all n l))))
    (foldr append '()
           (map (lambda (node) (create-pair-for-one node lon))
                lon))))


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


; Graph -> [List-of Node]
; produces all nodes of g, do not repeat any node.

(check-satisfied (extract-nodes sample-graph)
                 (check-nodes '(A B C D E F G)))

(define (extract-nodes G)
  (map first G))


;; check functions
; [List-of Node] -> [ [List-of Node] -> Boolean ]
; produces a function which determine whether l's items are all
; member of the given nodes.

(define (check-nodes nodes)
  (lambda (l) (andmap (lambda (item) (member? item nodes))
                      l)))


;; Questions
;; Q1: Which one does it find? <- (find-path 'A 'G sample-graph)
;; A1: '(A B E F G) is the answer. The second node is node A's
;; first neighbor, and E is the first neighbor of B, so if there
;; is any path from E to G, then B must in front of it; and for there
;; is not any path from C to G, and F is the next neighbor of node C,
;; so the 4th node is F, and G is the neighbor of F.

