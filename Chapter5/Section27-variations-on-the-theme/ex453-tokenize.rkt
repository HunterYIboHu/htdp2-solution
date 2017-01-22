;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex453-tokenize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data definitions
; A Line is a [List-of 1String].

; A Token is one of:
; - 1String
; - (implode [ List-of "[a-z]" ])
; interpretation a token is either a 1String or a String that
; consists of lower-case letters and nothing else. 


;; constants
(define Letter (explode "abcdefghijklmnopqrstuvwxyz"))

(define line-1 (explode "abc s g h\n"))
(define line-2 (explode " \r\n\t"))
(define line-3 (explode "abC s g\thiN\ns"))

(define tokens-1 '("abc" "s" "g" "h"))
(define tokens-2 '())
(define tokens-3 '("ab" "s" "g" "hi" "s"))


;; functions
; Line -> [List-of Token]
; produces a tokens list, which exclusive all white-space
; use string-whitespace? 
; and join all consecutive letters into word.

(check-expect (tokenize line-1) tokens-1)
(check-expect (tokenize line-2) tokens-2)
(check-expect (tokenize line-3) tokens-3)

(define (tokenize aline)
  (cond [(empty? aline) '()]
        [else (local ((define result (first-token aline))
                      (define next (tokenize (remove-first-token aline))))
                (if (string=? "" result)
                    next
                    (cons result next)))]))


;; auxiliary functions
; Line -> Token
; produces the first token by cons items but stops when encounter
; with whitespace or the end of list.

(check-expect (first-token line-1) "abc")
(check-expect (first-token line-2) "")
(check-expect (first-token '()) "")

(define (first-token aline)
  (cond [(empty? aline) ""]
        [(or (string-whitespace? (first aline))
             (not (letter? (first aline))))
         ""]
        [else (string-append (first aline)
                             (first-token (rest aline)))]))


; Line -> Line
; produces a new line exclusive the first token.

(check-expect (remove-first-token line-1) (explode "s g h\n"))
(check-expect (remove-first-token line-2) (explode "\r\n\t"))

(define (remove-first-token aline)
  (cond [(empty? aline) '()]
        [(or (string-whitespace? (first aline))
             (not (letter? (first aline))))
         (rest aline)]
        [else (remove-first-token (rest aline))]))


; 1String -> Boolean
; determine whether s is Letter.

(check-expect (letter? " ") #f)
(check-expect (letter? "F") #f)
(check-expect (letter? "a") #t)

(define (letter? s)
  (member? s Letter))

