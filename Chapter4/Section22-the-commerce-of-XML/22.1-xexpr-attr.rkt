;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 22.1-xexpr-attr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An Xexpr.v2 is a list: 
; – (cons Symbol XL)
; An XL is one of:
; – [List-of Xexpr.v2]
; – (cons [List-of Attribute] [List-of Xexpr.v2])
; 
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))


;; constants
(define a0 '((initial "X")))

(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))


;; functions
; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe.

(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) a0)
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) a0)

(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond [(empty? optional-loa+content) '()]
          [else (local ((define loa-or-x (first optional-loa+content)))
                     (if (list-of-attributes? loa-or-x)
                         loa-or-x
                         '()))])))


;; auxiliary functions
; [List-of Attribute] or Xexpr.v2 -> Boolean
; determine whether x is an element of [List-of Attribute]
; #false otherwise

(check-expect (list-of-attributes? a0) #true)
(check-expect (list-of-attributes? '()) #true)
(check-expect (list-of-attributes? '(action)) #false)

(define (list-of-attributes? x)
  (cond [(empty? x) #true]
        [else (local ((define possible-attribute (first x)))
                (cons? possible-attribute))]))

