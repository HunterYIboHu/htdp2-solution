;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex322-contains-bt) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
; A BinaryTree (short for BT) is one of:
; - NONE
; - (make-node Number Symbol BT BT)


;; constants
(define tree-A (make-node 15 'd NONE (make-node 24 'i NONE NONE)))
(define tree-B (make-node 15 'd (make-node 87 'h NONE NONE) NONE))


;; functions
; BT Number -> Boolean
; determine whether a given number occurs in given bt.

(check-expect (contains-bt? tree-A 15) #true)
(check-expect (contains-bt? tree-A 24) #true)
(check-expect (contains-bt? tree-A 87) #false)
(check-expect (contains-bt? tree-B 87) #true)
(check-expect (contains-bt? tree-B 15) #true)

(define (contains-bt? bt code)
  (cond [(equal? bt NONE) #false]
        [else (or (contains-bt? (node-left bt) code)
                  (contains-bt? (node-right bt) code)
                  (= code (node-ssn bt)))]))