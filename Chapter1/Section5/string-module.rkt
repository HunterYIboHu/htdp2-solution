;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname string-module) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 1-String
; String consist of one character


; String -> Boolean
; determine weather the string's length is larger than 0-
; examples:
(check-expect (valid-string? "Hello")
              (> (string-length "Hello") 0))
(check-expect (valid-string? "")
              (> (string-length "") 0))

(define (valid-string? str)
  (> (string-length str) 0))


; String -> 1-String
; (string-first str) means extract the fisrt character of str
; then return a 1-String consist of this character
; examples:
(check-expect (string-first "Hello") (string-ith "Hello" 0))
(check-expect (string-first "") "")

(define (string-first str)
  (cond [(valid-string? str) (string-ith str 0)]
        [else ""]))


; String -> String
; (string-rest str) means extract the whole string exclude the
; first character.
; examples:
(check-expect (string-rest "Hello") (substring "Hello" 1))
(check-expect (string-rest "") "")

(define (string-rest str)
  (cond [(valid-string? str) (substring str 1)]
        [else ""]))


; String -> Number
; return the last position of given Stirng
; examples:
(check-expect (last-p "Hello") (- (string-length "Hello") 1))

(define (last-p str) (- (string-length str) 1))


; String -> 1-String
; (string-last str) extract the last character of string
; then return it. If consume a 1-String, just return it.
; examples:
(check-expect (string-last "Hello")
              (substring "Hello" (last-p "Hello")))
(check-expect (string-last "") "")

(define (string-last str)
  (cond [(valid-string? str)
         (substring str (last-p str))]
        [else ""]))


; String -> String
; (string-remove-last str) means remove the last character of
; str, then return the rest.
; examples:
(check-expect (string-remove-last "Hello")
              (substring "Hello" 0 (last-p "Hello")))
(check-expect (string-remove-last "") "")

(define (string-remove-last str)
  (cond [(valid-string? str) (substring str 0 (last-p str))]
        [else ""]))








