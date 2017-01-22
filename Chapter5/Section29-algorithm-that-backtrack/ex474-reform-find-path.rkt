;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex474-reform-find-path) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(check-error (find-path 'B 'C '()))
(check-error (find-path 'H 'B sample-graph))
(check-error (find-path 'H 'H sample-graph))

(define (find-path origination destination G)
  (cond [(symbol=? origination destination)
         (if (and (cons? G)
                  (member? origination (map first G)))
             (list destination)
             (error "The given G or node is not satisfied."))]
        [else (local (; Node -> [List-of Node]
                      ; produces the neighbors of n in G.
                      ; if n is not a node of G, or G is empty,
                      ; then signals an error.
                      (define (neighbors n)
                        (cond [(empty? G)
                               (error "There is no node in G.")]
                              [(not (member? n (map first G)))
                               (error "The given node is not in G.")]
                              [else (second (assq n G))]))
                      ; [List-of Node] Node -> [Maybe Path]
                      ; finds a path from some node on
                      ; lo-originations to destination;
                      ; otherwise, it produces #false.
                      (define (find-path/list lo-Os D)
                        (cond [(empty? lo-Os) #false]
                              [else (local ((define candidate
                                              (find-path (first lo-Os) D G)))
                                      (cond [(boolean? candidate)
                                             (find-path/list (rest lo-Os) D)]
                                            [else candidate]))]))
                      
                      (define next (neighbors origination))
                      (define candidate
                        (find-path/list next destination)))
                (cond [(boolean? candidate) #false]
                      [else (cons origination candidate)]))]))

