;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex375-change-bulletize-wrap) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define SIZE 12)
(define COLOR 'black)
(define BULLET
  (beside (circle 1 'solid 'black) (text " " SIZE COLOR)))

(define word-1 '(word ((text "libary"))))
(define word-2 '(word ((text "racket"))))
(define word-3 '(word ((text "parser"))))

(define a0 '((initial "X")))

(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

(define xe0 '(ul (li (word ((text "one"))))
                 (li (word ((text "two"))))))

(define xi0 '(li ,xe0))


;; functions
; String -> Image
; render the text as image, in Consolas.

(check-expect (text/con "one")
              (text/font "one" SIZE COLOR "Consolas" 'default
                         'normal 'normal #f))
(check-expect (text/con "two")
              (text/font "two" SIZE COLOR "Consolas" 'default
                         'normal 'normal #f))

(define (text/con s)
  (text/font s SIZE COLOR "Consolas" 'default
             'normal 'normal #f))


; Image -> Image
; marks an bullet in front of the given img.

(check-expect (bulletize (text/con "one"))
              (beside/align 'center BULLET (text/con "one")))
(check-expect (bulletize (text/con "two"))
              (beside/align 'center BULLET (text/con "two")))

(define (bulletize img)
  (beside/align 'center BULLET img))


; XEnum.v2 -> Image
; render the given xe into image.

(check-expect (render-enum xe0)
              (above/align 'left
                           (bulletize (text/con "one"))
                           (bulletize (text/con "two"))))

(define (render-enum xe)
  (local ((define loi (xexpr-content xe))
          ; XItem.v2 Image-> Image
          ; stack the rendered xi onto the given img.
          (define (stack-img item img)
            (above/align 'left
                         (render-item item)
                         img)))
    (foldr stack-img empty-image loi)))



; XItem.v2 -> Image
; render the given xi into image.

(check-expect (render-item '(li (word ((text "two")))))
              (bulletize (text/con "two")))
(check-expect (render-item '(li (word ((text "one")))))
              (bulletize (text/con "one")))
(check-expect (render-item `(li ,xe0))
              (bulletize (above/align 'left
                                      (bulletize (text/con "one"))
                                      (bulletize (text/con "two")))))

(define (render-item xi)
  (local ((define content (xexpr-content xi))
          (define element (first content)))
    (cond [(word? element) (bulletize (text/con (word-text element)))]
          [else (bulletize (render-enum element))])))


;; Questions
;; Q1: Why are you confident that your change works?
;; A1: Because the only change is moce the function application of bulletize
;; into the cond clause.
;; Q2: Which version do you prefer?
;; A2: I prefer the one before changed, means wrapping of cond with (bulletize ...)


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

