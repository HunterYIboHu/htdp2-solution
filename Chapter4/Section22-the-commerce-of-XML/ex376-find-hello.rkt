;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex376-find-hello) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define xe0 '(ul (li (word ((text "one"))))
                 (li (word ((text "two"))))))
(define xe1 `(ul ,xi1 ,xi1 ,xi1 ,xi2))
(define xe2 `(ul (li ,xe0)
                 (li ,xe1)
                 ,xi1))

(define xi0 `(li ,xe0))
(define xi3 `(li ,xe1))


;; functions
; XEnum.v2 -> Number
; produces the number of "hello" in xe.

(check-expect (find-hello/enum xe0) 0)
(check-expect (find-hello/enum xe1) 3)
(check-expect (find-hello/enum xe2) 4)

(define (find-hello/enum xe)
  (local ((define items (xexpr-content xe))
          (define (sum l)
            (foldr + 0 l)))
    (sum (map find-hello/item items))))


; XItem.v2 -> Number
; prodcues the number of "hello" in xi.

(check-expect (find-hello/item xi1) 1)
(check-expect (find-hello/item xi0) 0)
(check-expect (find-hello/item xi3) 3)

(define (find-hello/item xi)
  (local ((define content (xexpr-content xi))
          (define word-or-enum (first content)))
    (cond [(word? word-or-enum)
           (if (string=? "hello" (word-text word-or-enum)) 1 0)]
          [else (find-hello/enum word-or-enum)])))


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

