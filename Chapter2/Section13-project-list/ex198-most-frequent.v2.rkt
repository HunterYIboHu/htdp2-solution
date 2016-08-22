;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex198-most-frequent.v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; determine which letter is most frequently used in the given dict,
; produces a pair to answer it.

(check-expect (most-frequent.v2 SUPER-SMALL) pair-a)
(check-expect (most-frequent.v2 (rest SUPER-SMALL)) pair-r)
(check-expect (most-frequent.v2 '()) FALSE)

(define (most-frequent.v2 dict)
  (cond [(empty? dict) FALSE]
        [else (auxi/frequence (words-by-first-letter dict) FALSE)]))


; Dictionary -> List-of-dictionary
; produces a list of Dictionary, one per letter

(check-expect (words-by-first-letter (list "almost"))
              (cons (list "almost") (make-list 25 '())))
(check-expect (words-by-first-letter SUPER-SMALL)
              (list (list "art" "angle" "artist") '() '() '()
                    (list "eye")
                    (list "first" "fast") '() '() '() '() '() '() '()
                    (list "nothing") '() '() '()
                    (list "rest" "real") '() '() '() '() '() '() '() '()))
(check-expect (words-by-first-letter '()) (list '()))

(define (words-by-first-letter dict)
  (cond [(empty? dict) (list '())]
        [else (auxi/words LETTERS dict)]))


;; auxiliary functions
; List-of-dictionary PLN -> PLN
; determine the largest list and produce the specfic pair of letter and
; the dictionary's length.

(check-expect (auxi/frequence (list '()) FALSE) FALSE)
(check-expect (auxi/frequence (list (list "art" "angle" "artist")
                                    (list "rest" "real")
                                    '()) FALSE)
              pair-a)
(check-expect (auxi/frequence (list (list "rest" "real")) FALSE) pair-r)
(check-expect (auxi/frequence (list (list "eye")
                                    (list "first" "fast")
                                    (list "nothing")
                                    (list "rest" "real")) FALSE)
              pair-r)

(define (auxi/frequence lod g-pln)
  (cond [(empty? lod) g-pln]
        [else (auxi/frequence (rest lod)
                              (if (<= (pair-count g-pln) (length (first lod)))
                                  (auxi/pair (first lod))
                                  g-pln))]))


; Dictionary -> PLN
; produces a pair which contains the first letter of the first word and
; the length of given dict.

(check-expect (auxi/pair (list "art" "angle" "artist")) (make-pair "a" 3))
(check-expect (auxi/pair (list "rest" "real")) (make-pair "r" 2))
(check-expect (auxi/pair '()) FALSE)

(define (auxi/pair dict)
  (if (empty? dict)
      FALSE
      (make-pair (first (explode (first dict))) (length dict))))


; List-of-letters Dictionary -> List-of-dictionary
; produces the list of dictionary which per letter per dictionary.

(check-expect (auxi/words (explode "ars") SUPER-SMALL)
              (list (list "art" "angle" "artist")
                    (list "rest" "real")
                    '()))
(check-expect (auxi/words (explode "a") SUPER-SMALL)
              (list (list "art" "angle" "artist")))

(define (auxi/words lol dict)
  (cond [(empty? lol) '()]
        [else (cons (auxi/gather (first lol) dict)
                    (auxi/words (rest lol) dict))]))


; Letter Dictionary -> Dictionary
; combine the words with the first letter is given l

(check-expect (auxi/gather "a" SUPER-SMALL)
              (list "art" "angle" "artist"))
(check-expect (auxi/gather "r" SUPER-SMALL)
              (list "rest" "real"))
(check-expect (auxi/gather "g" SUPER-SMALL) '())
(check-expect (auxi/gather "g" '()) '())

(define (auxi/gather l dict)
  (cond [(empty? dict) '()]
        [else (if (string=? l (first (explode (first dict))))
                  (cons (first dict) (auxi/gather l (rest dict)))
                  (auxi/gather l (rest dict)))]))

