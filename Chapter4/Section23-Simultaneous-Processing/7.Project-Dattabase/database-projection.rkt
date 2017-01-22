;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname database-projection) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct db [schema content])
; A DB is a structure:
;    (make-db Schema Content)

; A Schema is a [List-of Spec]
; A Spec is a [List Label Predicate]
; A Label is a String
; A Predicate is a [Any -> Boolean]

; A (piece of) Content is a [List-of Row]
; A Row is [List-of Cell]
; A Cell is Any
; constraint cells do not contain functions

; intergrity constraint In (make-db sch con),
; for every row in con,
; (I1) its length is the same as sch's, and
; (I2) its ith Cell satisfies the ith Predicate in sch


;; constants
(define srow-1 '("Alice" 35 #true))
(define srow-2 '("Bob" 25 #false))
(define srow-3 '("Carol" 30 #true))
(define srow-4 '("Dave" 32 #false))

(define scol-1 `("Name" ,string?))
(define scol-2 `("Age" ,integer?))
(define scol-3 `("Present" ,boolean?))

(define school-schema `(,scol-1 ,scol-2 ,scol-3))
(define presence-schema `(("Present" ,boolean?)
                          ("Description" ,string?)))
(define projected-schema `(("Name" ,string?)
                           ("Present" ,boolean?)))

(define school-content `(,srow-1 ,srow-2 ,srow-3 ,srow-4))
(define presence-content '((#true "presence")
                           (#false "absence")))
(define projected-content '(("Alice" #true)
                            ("Bob" #false)
                            ("Carol" #true)
                            ("Dave" #false)))

(define school-db (make-db school-schema
                           school-content))
(define presence-db (make-db presence-schema
                             presence-content))
(define projected-db (make-db projected-schema
                              projected-content))


;; functions
; DB [List-of Label] -> DB
; retain a column from ab if its label is in labels

(check-expect (db-content (project school-db '("Name" "Present")))
              projected-content)
(check-expect (db-content (project presence-db '("Present")))
              '((#true) (#false)))

(define (project db labels)
  (local ((define schema (db-schema db))
          (define content (db-content db))
          ; Spec -> Boolean
          ; does this spec belong to the new schema
          (define (keep? c)
            (member? (first c) labels))
          ; Row -> Row
          ; retains those columns whose name is in labels
          (define (row-project row)
            (foldr (lambda (cell m c) (if m (cons cell c) c))
                   '() row mask))
          (define mask (map keep? schema)))
    (make-db (filter keep? schema)
             (map row-project content))))