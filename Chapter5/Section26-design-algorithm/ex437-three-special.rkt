;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex437-three-special) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; functions
; [List-of Any] -> N
; computes the input's length.

(check-expect (list-length '(1 2 3 4 5 6)) 6)
(check-expect (list-length '("a" #f)) 2)
(check-expect (list-length '()) 0)

(define (list-length input)
  (cond [(empty? input) 0]
        [else (add1 (list-length (rest input)))]))


; [List-of Number] -> [List-of Number]
; produces a list of number which negates each number of input.

(check-expect (negate-list '(1 2 3)) '(-1 -2 -3))
(check-expect (negate-list '(1 -3 2)) '(-1 3 -2))
(check-expect (negate-list '()) '())

(define (negate-list input)
  (cond [(empty? input) '()]
        [else (cons (- (first input))
                    (negate-list (rest input)))]))


; [List-of String] -> [List-of String]
; produces a list contains strings which uppercases the given string of
; input.

(check-expect (uppercase-list '("a" "b" "c")) (explode "ABC"))
(check-expect (uppercase-list '("absolute" "brack" "paper"))
              '("ABSOLUTE" "BRACK" "PAPER"))
(check-expect (uppercase-list '("ABC" "nothing" "Knuth"))
              '("ABC" "NOTHING" "KNUTH"))

(define (uppercase-list input)
  (cond [(empty? input) '()]
        [else (cons (uppercase (explode (first input)))
                    (uppercase-list (rest input)))]))


;; auxiliary functions
; [List-of 1String] -> String
; produces a string which contains the uppercase version of the 1String
; in the input.

(check-expect (uppercase (explode "abc")) "ABC")
(check-expect (uppercase (explode "aBc")) "ABC")
(check-expect (uppercase '()) "")

(define (uppercase input)
  (cond [(empty? input) ""]
        [else
         (local (; 1String -> 1String
                 ; uppercase the given s.
                 (define (upper s)
                   (if (string-lower-case? s)
                       (int->string (- (string->int s) 32))
                       s)))
           (string-append (upper (first input))
                          (uppercase (rest input))))]))






