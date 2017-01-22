;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex325-search-bst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
; A BinaryTree (short for BT) is one of:
; - NONE
; - (make-node Number Symbol BT BT)


;; constants
(define tree-A (make-node 15 'd
                          NONE
                          (make-node 24 'i NONE NONE)))
(define tree-B (make-node 15 'd
                          (make-node 87 'h NONE NONE)
                          NONE))
(define tree-C (make-node 63 'a
                          (make-node 29 'b
                                     (make-node 15 'c
                                                (make-node 10 'd NONE NONE)
                                                (make-node 24 'e NONE NONE))
                                     NONE)
                          (make-node 89 'f
                                     (make-node 77 'g NONE NONE)
                                     (make-node 95 'h
                                                NONE
                                                (make-node 99 'i NONE NONE)))))
(define tree-D (make-node 63 'a
                          (make-node 29 'b
                                     (make-node 15 'c
                                                (make-node 8 'd NONE NONE)
                                                (make-node 24 'e NONE NONE))
                                     NONE)
                          (make-node 89 'f
                                     (make-node 69 'g NONE NONE)
                                     (make-node 95 'h
                                                NONE
                                                (make-node 99 'i NONE NONE)))))


;; functions
; Number BST -> Symbol Or NONE
; produces the value of the name if the tree contains a node whose ssn field is n.

(check-expect (search-bst 25 tree-A) NONE)
(check-expect (search-bst 24 tree-A) 'i)
(check-expect (search-bst 24 tree-C) 'e)
(check-expect (search-bst 69 tree-D) 'g)

(define (search-bst n bst)
  (cond [(no-info? bst) NONE]
        [else (local ((define code (node-ssn bst)))
                (cond [(= n code) (node-name bst)]
                      [(< n code) (search-bst n (node-left bst))]
                      [(> n code) (search-bst n (node-right bst))]))]))