;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex403-struct-spec) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct db [schema content])
; A DB is a structure:
;    (make-db Schema Content)

; A Schema is a [List-of Spec]

(define-struct spec [label predicate])
; Spec is a structure: (make-spec Label Predicate)
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

(define scol-1 (make-spec "Name" string?))
(define scol-2 (make-spec "Age" integer?))
(define scol-3 (make-spec "Present" boolean?))

(define school-schema `(,scol-1 ,scol-2 ,scol-3))
(define presence-schema `(,(make-spec "Present" boolean?)
                          ,(make-spec "Description" string?)))

(define school-content `(,srow-1 ,srow-2 ,srow-3 ,srow-4))
(define presence-content '((#true "presence")
                           (#false "absence")))

(define school (make-db school-schema school-content))
(define presence (make-db presence-schema presence-content))

