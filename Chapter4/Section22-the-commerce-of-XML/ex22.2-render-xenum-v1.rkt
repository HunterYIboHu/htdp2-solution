;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex22.2-render-xenum-v1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;; data difinitions
; An XEnum.v1 is one of: 
; – (cons 'ul [List-of XItem.v1])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v1]))
; An XItem.v1 is one of:
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
;
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))
;
; An XWord is '(word ((text String)))


; An Xexpr.v2 is a list: 
; – (cons Symbol XL)
; if there is onely one empty list, the list means the missing of attributes.

; An XL is one of:
; – [List-of Xexpr.v2]
; – (cons [List-of Attribute] [List-of Xexpr.v2])


;; constants
(define xe0 '(ul (li (word ((text "one"))))
                 (li (word ((text "two"))))))

(define word-1 '(word ((text "libary"))))
(define word-2 '(word ((text "racket"))))
(define word-3 '(word ((text "parser"))))

(define a0 '((initial "X")))

(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))


;; definition used functions
; String -> Image
; add a space to the head of string.

(check-expect (add-space " ") (text/font "  " 24 'black "Consolas"
                                         'default 'normal 'normal #f))
(check-expect (add-space "one") (text/font " one" 24 'black "Consolas"
                                           'default 'normal 'normal #f))

(define (add-space s)
  (text/font (string-append " " s) 24 'black "Consolas" 'default
             'normal 'normal #f))


(define BULLET (circle 3 "solid" "black"))
(define xe0-rendered
  (above/align 'left
               (beside/align 'center BULLET (add-space "one"))
               (beside/align 'center BULLET (add-space "two"))))


;; functions
; XEnum.v1 -> Image
; renders a simple enumeration as an image.

(check-expect (render-enum1 xe0) xe0-rendered)

(define (render-enum1 xe)
  (local ((define content (xexpr-content xe))
          ; XItem.v1 Image -> Image
          (define (deal-with-one item so-far)
            (above/align 'left
                         (render-item1 item)
                         so-far)))
    (foldr deal-with-one empty-image content)))


; XItem.v1 -> Image
; render the item as a image.

(check-expect (render-item1 '(li (word ((text "one")))))
              (beside/align 'center BULLET (add-space "one")))
(check-expect (render-item1 '(li (word ((text "two")))))
              (beside/align 'center BULLET (add-space "two")))

(define (render-item1 i)
  (local ((define content (xexpr-content i))
          (define element (first content))
          (define a-word (word-text element))
          (define item (add-space a-word)))
    (beside/align 'center BULLET item)))


;;;;question;;;;
;; Q1: how the function works?
;; A1: get the content of li element, is a list consist of an XWord;
;; then get the element, and extract the text of the given element;
;; render it as a text instance is the next step; finally, render a BULLET
;; beside the text instance.


;; auxiliary functions
; XWord -> String
; produces the content of the given w.

(check-expect (word-text word-1) "libary")
(check-expect (word-text word-2) "racket")
(check-expect (word-text word-3) "parser")

(define (word-text w)
  (second (first (second w))))


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