;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex326-create-bst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
                      [(> N code) (make-node code (node-name B)
                                             (node-left B)
                                             (create-bst (node-right B) N S))]))]))

