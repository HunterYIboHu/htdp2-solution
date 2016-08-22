;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex196-count-by-letter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; constants
(define DICTIONARY-LOCATION "en_US.dic")
(define SMALL-DIC "words.txt")


;; data difinitions
; A Dictionary is a List-of-strings
;(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))
;(define DICTIONARY-AS-LIST-S (read-lines SMALL-DIC))
(define SUPER-SMALL (list "art" "angle" "artist" "rest" "first" "nothing" "real" "fast" "eye"))


; A Letter is one of the following 1Strings:
; - "a"
; - ...
; - "z"
; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))


;; main functions
; List-of-letters Dictionary -> List-of-numbers
; produces a list which contains the number of words which starts with the letters
; on the given list in order.

(check-expect (count-by-letter (list "a") SUPER-SMALL) (list 3))
(check-expect (count-by-letter (explode "ars") SUPER-SMALL) (list 3 2 0))
(check-expect (count-by-letter (explode "nra") SUPER-SMALL) (list 1 2 3))
(check-expect (count-by-letter (explode "stv") SUPER-SMALL) (list 0 0 0))
(check-expect (count-by-letter (explode "ars") '()) (list 0 0 0))

(define (count-by-letter lol d)
  (cond [(empty? lol) '()]
        [else (cons (starts-with# (first lol) d)
                    (count-by-letter (rest lol) d))]))


;; auxiliary functions
; Letter Dictionary -> Number
; determine the number of words which starts with the given l in d

(check-expect (starts-with# "a" SUPER-SMALL) 3)
(check-expect (starts-with# "r" SUPER-SMALL) 2)
(check-expect (starts-with# "n" SUPER-SMALL) 1)
(check-expect (starts-with# "s" SUPER-SMALL) 0)
(check-expect (starts-with# "s" '()) 0)

(define (starts-with# l d)
  (cond [(empty? d) 0]
        [else (if (string=? l (first (explode (first d))))
                  (add1 (starts-with# l (rest d)))
                  (starts-with# l (rest d)))]))


;; call functions
;(count-by-letter LETTERS DICTIONARY-AS-LIST)

