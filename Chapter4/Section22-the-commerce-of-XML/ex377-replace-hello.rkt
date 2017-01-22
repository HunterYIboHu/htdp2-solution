;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex377-replace-hello) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; data difinitions
; An XItem.v2 is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] XWords))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] XEnums))
; 
; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))
;
; An XWords is one of:
; - '()
; - (cons XWord XWords)
;
; An XEnums is one of:
; - '()
; - (cons XEnum.v2 XEnums)

; An Xexpr.v2 is a list: 
; – (cons Symbol XL)
; An XL is one of:
; – [List-of Xexpr.v2]
; – (cons [List-of Attribute] [List-of Xexpr.v2])

; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))


;; constants

(define word-1 '(word ((text "libary"))))
(define word-2 '(word ((text "racket"))))
(define word-3 '(word ((text "parser"))))
(define hello '(word ((text "hello"))))
(define bye '(word ((text "bye"))))

(define a0 '((initial "X")))
(define a1 '((initial "X") (exact "true") (support-1.1 "true")))
(define a2 '((exact "true") (racket-version "6.5[3m]")))

(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

(define xi1 `(li ,hello))
(define xi2 `(li ,bye))
(define xi-hello `(li ((like "hello")) ,hello))

(define xe0 '(ul (li (word ((text "one"))))
                 (li (word ((text "two"))))))
(define xe1 `(ul ,xi1 ,xi1 ,xi1 ,xi2))
(define xe2 `(ul (li ,xe0)
                 (li ,xe1)
                 ,xi1))

(define xi0 `(li ,xe0))
(define xi3 `(li ,xe1))


;; functions
; XEnum.v2 -> XEnum.v2
; produces the given xe with all "hello" are replaced with "bye".

(check-expect (replace-hello/enum xe0) xe0)
(check-expect (replace-hello/enum xe1) `(ul ,xi2 ,xi2 ,xi2 ,xi2))
(check-expect (replace-hello/enum xe2) `(ul (li ,xe0)
                                            (li (ul ,xi2 ,xi2 ,xi2 ,xi2))
                                            ,xi2))

(define (replace-hello/enum xe)
  (local ((define items (xexpr-content xe)))
    (cons 'ul (map replace-hello/item items))))


; XItem.v2 -> XItem.v2
; produces the given xi with all "hello" are replaced with "bye".

(check-expect (replace-hello/item xi1) `(li ,bye))
(check-expect (replace-hello/item xi2) xi2)
(check-expect (replace-hello/item xi0) xi0)
(check-expect (replace-hello/item xi3) `(li (ul ,xi2 ,xi2 ,xi2 ,xi2)))
(check-expect (replace-hello/item xi-hello) `(li ((like "bye")) ,bye))
(check-expect (replace-hello/item `(li ((like "hello")) ,bye))
              `(li ((like "bye")) ,bye))

(define (replace-hello/item xi)
  (local ((define attributes (xexpr-attr xi))
          (define content (xexpr-content xi))
          (define word-or-enum (first content)))
    (cond [(word? word-or-enum)
           (if (string=? "hello" (word-text word-or-enum))
               (if (empty? attributes)
                   `(li (word ((text "bye"))))
                   `(li ,(replace-hello/attr attributes) (word ((text "bye")))))
               `(li ,@(if (empty? attributes)
                         `(,word-or-enum)
                         (cons (replace-hello/attr attributes) content))))]
          [else `(li ,(replace-hello/enum word-or-enum))])))


; Attribute -> Attribute
; replace all "hello" in the attr, then return it.

(check-expect (replace-hello/attr '((like "hello")
                                    (no "hello")
                                    (bye "bye")))
              '((like "bye") (no "bye") (bye "bye")))

(define (replace-hello/attr attrs)
  (map (lambda (a) (if (string=? "hello" (second a))
                       `(,(first a) "bye")
                       a)) attrs))


;; auxiliary functions
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


; X -> Boolean
; determine whether the input is XWord.

(check-expect (word? "string") #f)
(check-expect (word? '(word ((text #true)))) #f)
(check-expect (word? #true) #f)
(check-expect (word? (make-posn 10 20)) #f)
(check-expect (word? word-1) #t)
(check-expect (word? word-2) #t)

(define (word? x)
  (if (and (cons? x)
           (not (empty? (rest x)))
           (not (empty? (second x)))
           (not (empty? (first (second x)))))
      (local ((define pair (first (second x))))
        (and (symbol=? (first x) 'word)
             (symbol=? (first pair) 'text)
             (not (empty? (rest pair)))
             (string? (second pair))))
      #false))


; XWord -> String
; produces the content of the given w.

(check-expect (word-text word-1) "libary")
(check-expect (word-text word-2) "racket")
(check-expect (word-text word-3) "parser")

(define (word-text w)
  (second (first (second w))))

