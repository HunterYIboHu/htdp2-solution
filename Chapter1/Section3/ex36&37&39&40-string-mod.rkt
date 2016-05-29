;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname definition-string-mod) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; ex36
; String -> 1-String
; given: "Hello world", expect: "H"
; given: "Racket", expect: "R"
; extracts the first character str[0] from a non-empty string str.
(define (string-first str)
  (substring str 0 1))


; ex37
; String -> 1-String
; given: "Hello world", expect: "d"
; given: "Racket", expect: "t"
; extracts the last character from a non-empty string.
(define (string-last str)
  (substring str (- (string-length str) 1)))


; ex39
; String -> String
; given: "Hello world", expect: "ello world"
; given: "Racket", expect: "acket"
; consume a string str, produces a string with
; the first character removed.
(define (string-rest str)
  (substring str 1))


; ex40
; String -> String
; given: "Hello world", expect: "Hello worl"
; given: "Racket", expect: "Racke"
; given: "A", expect: ""
; produce a string like the given str with the last character
; removed.
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))






























