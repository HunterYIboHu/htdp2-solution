;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex366-xexpr-name-and-content) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An Xexpr.v2 is a list: 
; – (cons Symbol XL)
; if there is onely one empty list, the list means the missing of attributes.

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
; Xexpr.v2 -> Symbol
; produces the name of the given xe.

(check-expect (xexpr-name e0) 'machine)
(check-expect (xexpr-name '(matthew ,a0)) 'matthew)
(check-expect (xexpr-name e4) 'machine)

(define (xexpr-name xe)
  (first xe))


; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the content of the given xe by list of xexpr.

(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '((action)))
(check-expect (xexpr-content e3) '((action)))
(check-expect (xexpr-content e4) '((action) (action)))

(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond [(empty? optional-loa+content) '()]
          [else (local ((define c-or-loa (first optional-loa+content)))
                  (if (list-of-attributes? c-or-loa)
                      (rest optional-loa+content)
                      optional-loa+content))])))


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