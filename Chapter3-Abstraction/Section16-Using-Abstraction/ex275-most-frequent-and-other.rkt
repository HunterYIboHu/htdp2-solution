;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex275-most-frequent-and-other) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; constants
(define DICTIONARY-LOCATION "en_US.dic")
(define SMALL-DIC "words.txt")

;(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))
;(define DICTIONARY-AS-LIST-S (read-lines SMALL-DIC))
(define SUPER-SMALL '("art" "angle" "artist" "rest" "first" "nothing" "real"
                            "fast" "eye"))


;; data difinitions
; A Letter is one of the following 1Strings:
; - "a"
; - ...
; - "z"
; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))


(define-struct pair [letter count])
; A PLN(Pair-of-Letter-and-Number) is (make-pair 1String Number)
; (make-pair l c) the c is the count of words which starts with the letter.

(define pair-a (make-pair "a" 3))
(define pair-f (make-pair "f" 2))
(define pair-n (make-pair "n" 1))
(define pair-s (make-pair "s" 0))
(define FALSE (make-pair "_" -1))


;; main functions
; [List-of String] -> [Maybe PLN]
; determine which letter is used most frequently as the first letter of the
; word on the given d.
; P.S. when two pair's count equals, return the one whose letter is appeared
; in front of the other.

(check-expect (most-frequent SUPER-SMALL) pair-a)
(check-expect (most-frequent (rest (rest SUPER-SMALL))) pair-f)
(check-expect (most-frequent '()) #false)

(define (most-frequent d)
  (cond [(empty? d) #false]
        [else (local (; 1String String -> Boolean
                      ; determine whether the given word is starts with the
                      ; given 1String.
                      (define (starts-with letter word)
                        (string=? letter (first (explode word))))
                      ; 1String -> [List-of String]
                      ; gather the words which starts with the given 1string
                      (define (gather-words letter)
                        (filter (lambda (x) (starts-with letter x)) d))
                      ; 1String -> PLN
                      ; create a pair according to the given letter and the
                      ; word's count.
                      (define (create-pair letter)
                        (make-pair letter (length (gather-words letter)))))
                (argmax pair-count (map create-pair LETTERS)))]))


; [List-of String] -> [List-of [List-of String]]
; consume a Dictionary and produces a list of Dictionary, one per Letter.
; Do not include '() if there are no words for some letter; ignore it.

(check-expect (words-by-first-letter SUPER-SMALL)
              '(("art" "angle" "artist") ("eye") ("first" "fast") ("nothing") ("rest" "real")))
(check-expect (words-by-first-letter '()) '())

(define (words-by-first-letter dict)
  (cond [(empty? dict) '()]
        [else (local (; 1String String -> Boolean
                      ; determine whether the given word is starts with the
                      ; given 1String.
                      (define (starts-with letter word)
                        (string=? letter (first (explode word))))
                      ; 1String -> [List-of String]
                      ; gather the words which starts with the given 1string
                      (define (gather-words letter)
                        (filter (lambda (x) (starts-with letter x)) dict)))
                (filter (lambda (x) (not (empty? x)))
                        (map gather-words LETTERS)))]))









