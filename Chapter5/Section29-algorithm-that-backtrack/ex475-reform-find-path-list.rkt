;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex475-reform-find-path-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(check-expect (find-path 'E 'D sample-graph)
              '(E C D))
(check-expect (find-path 'C 'G sample-graph)
              #false)
(check-expect (find-path 'A 'G sample-graph)
              '(A B E F G))
(check-expect (find-path 'B 'C cyclic-graph)
              '(B E C))

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
  (local ((define result
            (filter (lambda (candidate) (not (boolean? candidate)))
                    (map (lambda (node) (find-path node D G))
                         lo-Os))))
    (if (empty? result)
        #false
        (first result))))


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
         (error (string-append "The given node "
                               (symbol->string n)
                               " is not in g:"
                               (foldl (lambda (x base)
                                        (string-append base " " x))
                                      ""
                                      (map symbol->string
                                           (map first g)))))]
        [else (second (assq n g))]))


;; Questions
;; Q1: how does Racket's ormap differ from ISL+'s ormap?
;; A1: the former wound return the first value which is not #false.
;;
;; Q2: Would the former be helpful here?
;; A2: Sure it is. With the help of the former ormap, we can simplify
;; the definition of find-path/list like:
;; (ormap (lambda (node) (find-path node D G)) lo-Os)

