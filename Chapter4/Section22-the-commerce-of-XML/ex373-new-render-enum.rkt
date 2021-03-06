;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex373-new-render-enum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; data difinitions
; An XItem.v2 is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (list XWord)))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] (list XEnum.v2)))
; 
; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))


;; constants
(define SIZE 12) ; font size 
(define COLOR "black") ; font color 
(define BULLET ; a graphical constant 
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

(check-expect (text/con "one") (text/font "one" SIZE COLOR "Consolas" 'default
                                          'normal 'normal #f))
(check-expect (text/con "two") (text/font "two" SIZE COLOR "Consolas" 'default
                                          'normal 'normal #f))

(define (text/con s)
  (text/font s SIZE COLOR "Consolas" 'default
             'normal 'normal #f))


; Image -> Image
; marks item with bullet

(check-expect (bulletize (text/con "one"))
              (beside/align 'center BULLET (text/con "one")))
(check-expect (bulletize (text/con "two"))
              (beside/align 'center BULLET (text/con "two")))

(define (bulletize item)
  (beside/align 'center BULLET item))


; XEnum.v2 -> Image
; renders an XEnum.v2 as an image 

(check-expect (render-enum xe0)
              (above/align 'left
                           (bulletize (text/con "one"))
                           (bulletize (text/con "two"))))

(define (render-enum xe)
  (local ((define content (xexpr-content xe))
          ; XItem.v2 Image -> Image 
          (define (deal-with-one item so-far)
            (above/align 'left (render-item item) so-far)))
    (foldr deal-with-one empty-image content)))


; XItem.v2 -> Image
; renders one XItem.v2 as an image

(check-expect (render-item '(li (word ((text "two")))))
              (bulletize (text/con "two")))
(check-expect (render-item '(li (word ((text "one")))))
              (bulletize (text/con "one")))
(check-expect (render-item `(li ,xe0))
              (bulletize (above/align 'left
                                      (bulletize (text/con "one"))
                                      (bulletize (text/con "two")))))

(define (render-item an-item)
  (local ((define content (first (xexpr-content an-item))))
    (bulletize
     (cond
       [(word? content)
        (text/con (word-text content))]
       [else (render-enum content)]))))


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