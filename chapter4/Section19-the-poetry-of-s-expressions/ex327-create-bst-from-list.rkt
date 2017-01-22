;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex327-create-bst-from-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
                          NONE
                          (make-node 87 'h NONE NONE)))
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
; [List-of [List Number Symbol]] -> BST
; produces a BST according to the given list.

(check-expect (create-bst-from-list '((24 i) (15 d)))
              tree-A)
(check-expect (create-bst-from-list '((87 h) (15 d)))
              tree-B)
(check-expect (create-bst-from-list '((99 o)
                                      (77 l)
                                      (24 i)
                                      (10 h)
                                      (95 g)
                                      (15 d)
                                      (89 c)
                                      (29 b)
                                      (63 a)))
              (make-node 63 'a
                         (make-node 29 'b
                                    (make-node 15 'd
                                               (make-node 10 'h NONE NONE)
                                               (make-node 24 'i NONE NONE))
                                    NONE)
                         (make-node 89 'c
                                    (make-node 77 'l NONE NONE)
                                    (make-node 95 'g
                                               NONE
                                               (make-node 99 'o NONE NONE)))))

(define (create-bst-from-list l)
  (foldr (lambda (pair base) (create-bst base (first pair) (second pair)))
         NONE l))


;; auxiliary functions
; BST Number Symbol -> BST
; produces a BST like B but replace one NONE subtree with
; (make-node N S NONE NONE).

(check-expect (create-bst tree-A 20 's)
              (make-node 15 'd
                         NONE
                         (make-node 24 'i
                                    (make-node 20 's NONE NONE)
                                    NONE)))
(check-expect (create-bst tree-C 45 'n)
              (make-node 63 'a
                         (make-node 29 'b
                                    (make-node 15 'c
                                               (make-node 10 'd NONE NONE)
                                               (make-node 24 'e NONE NONE))
                                    (make-node 45 'n NONE NONE))
                         (make-node 89 'f
                                    (make-node 77 'g NONE NONE)
                                    (make-node 95 'h
                                               NONE
                                               (make-node 99 'i NONE NONE)))))

(define (create-bst B N S)
  (cond [(no-info? B) (make-node N S NONE NONE)]
        [else (local ((define code (node-ssn B)))
                (cond [(< N code) (make-node code (node-name B)
                                             (create-bst (node-left B) N S)
                                             (node-right B))]
                      [else (make-node code (node-name B)
                                       (node-left B)
                                       (create-bst (node-right B) N S))]))]))


;; Questions
;; Q1: If you use an existing abstraction, you may still get this tree but you
;; may also get an “inverted” one. Why?
;;
;; A1: Because the list's order may be inverted.