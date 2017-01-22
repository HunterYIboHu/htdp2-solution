;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 31.2-path-exists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data definitions
; A SimpleGraph is a [List-of Connection]
; A Connection is a list of two items:
;   (list Node Node)
; A Node is a Symbol.


;; data examples
(define a-sg
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F)))


;; functions
; Node Node SimpleGraph -> Boolean
; is there a path from origin to destination
; in the simple graph sg
 
(check-expect (path-exists? 'A 'E a-sg) #true)
(check-expect (path-exists? 'A 'F a-sg) #false)
 
(define (path-exists? origin destination sg)
  (cond [(symbol=? origin destination) #true]
        [else (path-exists? (neighbor origin sg)
                            destination
                            sg)]))


; Node Node SimpleGraph -> Boolean
; is there a path from origin to destination in sg

(check-expect (path-exists.v2? 'A 'E a-sg) #true)
(check-expect (path-exists.v2? 'A 'F a-sg) #false)

(define (path-exists.v2? origin destination sg)
  (local (; Node Node SimpleGraph [List-of Node] -> Boolean
          (define (path-exists?/a o d sg seen)
            (cond [(symbol=? o d) #t]
                  [(member? o seen) #f]
                  [else (path-exists?/a (neighbor o sg)
                                        d
                                        sg
                                        (cons o seen))])))
    (path-exists?/a origin destination sg '())))


;; auxiliary functions
; Node SimpleGraph -> Node
; determine the node that is connected to a-node in sg

(check-expect (neighbor 'A a-sg) 'B)
(check-error (neighbor 'G a-sg) "neighbor: not a node")

(define (neighbor a-node sg)
  (cond [(empty? sg) (error "neighbor: not a node")]
        [else (if (symbol=? (first (first sg)) a-node)
                  (second (first sg))
                  (neighbor a-node (rest sg)))]))









