;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex410-db-union) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
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
(define school-content-2 `(,srow-3
                           ("Matthew" 38 #false)))

(define school-db (make-db school-schema
                           school-content))
(define presence-db (make-db presence-schema
                             presence-content))
(define projected-db (make-db projected-schema
                              projected-content))
(define school-db-2 (make-db school-schema
                             school-content-2))


;; functions
; DB DB -> Db
; produces a new data base with the same schema of the given two,
; and eliminate rows with the exact same content.
; Assume that the schemas agree on the predicates for each column.

(check-expect (db-content (db-union school-db school-db-2))
              `(,@school-content ("Matthew" 38 #false)))
(check-expect (db-content (db-union school-db school-db))
              school-content)

(define (db-union origin new)
  (local ((define content (db-content origin))
          (define new-content
            (filter (lambda (row) (not (member? row content)))
                    (db-content new))))
    (make-db (db-schema origin)
             (append content new-content))))

