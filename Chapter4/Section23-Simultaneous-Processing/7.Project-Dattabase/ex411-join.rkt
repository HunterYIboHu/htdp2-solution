;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex411-join) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define new-presence-content '((#true "presence")
                               (#true "here")
                               (#false "absence")
                               (#false "there")))

(define school-db (make-db school-schema
                           school-content))
(define presence-db (make-db presence-schema
                             presence-content))
(define projected-db (make-db projected-schema
                              projected-content))
(define new-presence-db (make-db presence-schema
                                 new-presence-content))


;; functions
; DB DB -> DB
; when second DB's schema starts with the exact same Spec that the
; schema of db-1 ends in, creates a data base from db-1 by replacing
; the last cell in each row with the translation of the cell in db-2.
;; asuming that a cell could only translate into another one cell.

(check-expect (db-content (join.v1 school-db presence-db))
              (db-content (make-db `(("Name" ,string?)
                                     ("Age" ,integer?)
                                     ("Description" ,string?))
                                   '(("Alice" 35 "presence")
                                     ("Bob" 25 "absence")
                                     ("Carol" 30 "presence")
                                     ("Dave" 32 "absence")))))
(check-error (db-content (join.v1 school-db school-db)))

(define (join.v1 db-1 db-2)
  (local ((define schema-1 (db-schema db-1))
          (define schema-2 (db-schema db-2))
          (define content-1 (db-content db-1))
          (define content-2 (db-content db-2))
          
          (define joinable
            (equal? (last schema-1) (first schema-2)))
          ; Content Content -> Content
          ; replace the origin's specfic column's cell
          ; according to the responding describe.
          (define (replace origin describe)
            (map (lambda (row)
                   `(,@(remove-last row)
                     ,(second (assoc (last row) describe))))
                 origin)))
    (if joinable
        (make-db `(,@(remove-last schema-1)
                   ,(second schema-2))
                 (replace content-1 content-2))
        (error "The two database cannot join together."))))


; DB DB -> DB
; when second DB's schema starts with the exact same Spec that the
; schema of db-1 ends in, creates a data base from db-1 by replacing
; the last cell in each row with the translation of the cell in db-2.

(check-expect (db-content (join.v2 school-db presence-db))
              (db-content (make-db `(("Name" ,string?)
                                     ("Age" ,integer?)
                                     ("Description" ,string?))
                                   '(("Alice" 35 "presence")
                                     ("Bob" 25 "absence")
                                     ("Carol" 30 "presence")
                                     ("Dave" 32 "absence")))))
(check-expect (db-content (join.v2 school-db new-presence-db))
              (db-content (make-db `(("Name" ,string?)
                                     ("Age" ,integer?)
                                     ("Description" ,string?))
                                   '(("Alice" 35 "presence")
                                     ("Alice" 35 "here")
                                     ("Bob" 25 "absence")
                                     ("Bob" 25 "there")
                                     ("Carol" 30 "presence")
                                     ("Carol" 30 "here")
                                     ("Dave" 32 "absence")
                                     ("Dave" 32 "there")))))
(check-error (db-content (join.v2 school-db school-db)))

(define (join.v2 db-1 db-2)
  (local ((define schema-1 (db-schema db-1))
          (define schema-2 (db-schema db-2))
          (define content-1 (db-content db-1))
          (define content-2 (db-content db-2)) 

          (define joinable
            (equal? (last schema-1) (first schema-2)))
          
          ; [X Y] [List-of Any] [List-of [List X Y]]
          ; -> (append [List-of Any] [List Y])
          ; add the second item of all the pairs to the given l's end.
          (define (connect-pairs l pairs)
            (foldr (lambda (new-row base) (cons new-row base))
                   '()
                   (map (lambda (pair) `(,@l
                                         ,(second pair)))
                        pairs)))
          ; Content Content -> Content
          ; replace the origin's specfic cell into new cell
          ; (may more than 1) according to the given describe.
          (define (replace origin describe)
            (foldr (lambda (row base)
                     (local ((define pairs (find-all-pair (last row) describe))
                             (define body (remove-last row)))
                       (append (connect-pairs body pairs) base)))
                   '() origin)))
    (if joinable
        (make-db `(,@(remove-last schema-1)
                   ,(second schema-2))
                 (replace content-1 content-2))
        (error "The two database cannot join together."))))


;; auxiliary function
; [List-of Any] -> Any
; extracts the last item of the given l.

(check-expect (last '(1 2 3)) 3)
(check-expect (last '(a b "c")) "c")

(define (last l)
  (cond [(empty? (rest l)) (first l)]
        [else (last (rest l))]))


; [List-of Any] -> [List-of Any]
; remove the last item of the given l.

(check-expect (remove-last '(1 2 3)) '(1 2))
(check-expect (remove-last '("a" #false "c"))
              '("a" #f))

(define (remove-last l)
  (cond [(empty? (rest l)) '()]
        [else (cons (first l) (remove-last (rest l)))]))


; [X Y] X [List-of [List X Y]] -> [List-of [List X Y]]
; find all pairs in l whose first item is the given x.

(check-expect (find-all-pair 1 '((1 "a") (1 c) (2 #true) (1 #false)))
              '((1 "a") (1 c) (1 #false)))
(check-expect (find-all-pair 1 '((2 "a") (3 #false))) '())

(define (find-all-pair x pairs)
  (filter (lambda (pair) (equal? x (first pair)))
          pairs))



