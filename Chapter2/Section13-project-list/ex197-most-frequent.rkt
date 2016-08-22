;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex197-most-frequent) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


(define-struct pair [letter count])
; A PLN(Pair-of-Letter-and-Number) is (make-pair 1String Number)
; (make-pair l c) the c is the count of words which starts with the letter.

(define pair-a (make-pair "a" 3))
(define pair-r (make-pair "r" 2))
(define pair-n (make-pair "n" 1))
(define pair-s (make-pair "s" 0))
(define FALSE (make-pair "_" -1))


;; main functions
; Dictionary -> PLN
; determine which letter is used most frequently as the first letter of the
; word on the given d

(check-expect (most-frequent SUPER-SMALL) pair-a)
(check-expect (most-frequent (rest SUPER-SMALL)) pair-r)
(check-expect (most-frequent '()) FALSE)

(define (most-frequent d)
  (cond [(empty? d) FALSE]
        [else (auxi/comp (count-by-letter LETTERS d) FALSE)]))



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


; List-of-letters Dictionary -> List-of-PLN
; produces a list which contains the number of words which starts with the letters and
; the letter as a pair on the given list in order.

(check-expect (count-by-letter (list "a") SUPER-SMALL) (list pair-a))
(check-expect (count-by-letter (explode "ars") SUPER-SMALL) (list pair-a pair-r pair-s))
(check-expect (count-by-letter (explode "nra") SUPER-SMALL) (list pair-n pair-r pair-a))
(check-expect (count-by-letter (explode "stv") SUPER-SMALL) (list pair-s (make-pair "t" 0) (make-pair "v" 0)))
(check-expect (count-by-letter (explode "ars") '()) (list (make-pair "a" 0) (make-pair "r" 0) pair-s))

(define (count-by-letter lol d)
  (cond [(empty? lol) '()]
        [else (cons (make-pair (first lol) (starts-with# (first lol) d))
                    (count-by-letter (rest lol) d))]))


; List-of-PLN PLN -> PLN
; determine which count is the largest and return the count belonged pair.

(check-expect (auxi/comp (list pair-a) FALSE) pair-a)
(check-expect (auxi/comp '() FALSE) FALSE)
(check-expect (auxi/comp (list pair-r pair-s pair-a) FALSE) pair-a)
(check-expect (auxi/comp (list pair-s (make-pair "t" 0) (make-pair "v" 0))
                         FALSE) (make-pair "v" 0))

(define (auxi/comp lpln g-pln)
  (cond [(empty? lpln) g-pln]
        [else (if (<= (pair-count g-pln) (pair-count (first lpln)))
                  (auxi/comp (rest lpln) (first lpln))
                  (auxi/comp (rest lpln) g-pln))]))


;; call functions
;(most-frequent DICTIONARY-AS-LIST)

