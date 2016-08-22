;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex213-everywhere) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; constants
(define DICTIONARY-LOCATION "en_US.dic")


;; data difinitions
; A Word is one of:
; - '() or
; - (cons 1String Word)
; interpretation a String as a list of 1Strings(letters)

(define ED (explode "ed"))
(define RAT (explode "rat"))

; A List-of-words is one of:
; - '() or
; - (cons Word List-of-words)
; interpretation a list that consisit of Word.

(define RAT-L (list (explode "art") (explode "rat") (explode "tar")
                    (explode "atr") (explode "rta") (explode "tra")))
(define ED-L (list (explode "ed") (explode "de")))

; A Dictionary is a List-of-strings
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))
;(define DICTIONARY-AS-LIST-S (read-lines SMALL-DIC))
(define SMALL-DICTIONARY (list "art" "rat" "tar" "act" "cat"))


; A Letter is one of the following 1Strings:
; - "a"
; - ...
; - "z"
; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))


;; main functions
; String -> List-of-strings
; find all words that use the same letters as s

(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
(check-satisfied (alternative-words "rat") all-words-from-rat?)

(define (alternative-words s)
  (in-dictionary
   (words->strings
    (arrangements (string->word s)))))


; Word -> List-of-words
; creates all rearrangements of the letters in w

(check-satisfied (arrangements ED) all-word-from-ed)
(check-satisfied (arrangements RAT) all-word-from-rat)

(define (arrangements w)
  (cond [(empty? w) (list '())]
        [else (insert-everywhere/in-all-words (first w)
                                              (arrangements (rest w)))]))


;; auxiliary functions
; 1String List-of-words -> List-of-words
; produces a list of words with the first argument inserted at the
; beginning, between all letters, and at the end of all words of the given
; list.

(check-expect (insert-everywhere/in-all-words "a" '()) '())
(check-expect (insert-everywhere/in-all-words "a" (list '()))
              (list (list "a")))
(check-satisfied (insert-everywhere/in-all-words "d" (list (list "e"))) all-word-from-ed)
(check-satisfied (insert-everywhere/in-all-words "r" (list (list "a" "t")
                                                           (list "t" "a")))
                 all-word-from-rat)

(define (insert-everywhere/in-all-words l low)
  (cond [(empty? low) '()]
        [else (append (insert-everywhere/in-one-word l (first low) 0)
                      (insert-everywhere/in-all-words l (rest low)))]))


; 1String Word -> List-of-words
; produces a list of word with the first argument inserted at the begining,
; between all letters, and at the end of the given Word.

(check-expect (insert-everywhere/in-one-word "d" (list "e") 0)
              (list (explode "de") (explode "ed")))
(check-expect (insert-everywhere/in-one-word "r" (list "a" "t") 0)
              (list (explode "rat") (explode "art") (explode "atr")))

(define (insert-everywhere/in-one-word l w pos)
  (cond [(> pos (length w)) '()]
        [else (cons (consist-word l w pos)
                    (insert-everywhere/in-one-word l w (add1 pos)))]))


; 1String Word Number ->List-of-words
; produce a list of word with the first argument

(check-expect (consist-word "d" (list "e") 0) (explode "de"))
(check-expect (consist-word "a" (explode "bbr") 2) (explode "bbar"))

(define (consist-word l w pos)
  (explode (string-append (substring (implode w) 0 pos)
                          l
                          (substring (implode w) pos))))

; List-of-words -> List-of-strings
; turn all Words in low into Strings

(check-expect (words->strings (list (explode "cat") (explode "rat")))
              (list "cat" "rat"))
(check-expect (words->strings (list (explode "null") (explode "right")))
              (list "null" "right"))
(check-expect (words->strings '()) '())

(define (words->strings low)
  (cond [(empty? low) '()]
        [else (cons (word->string (first low))
                    (words->strings (rest low)))]))


; String -> Word
; convert s to the chosen word representation

(check-expect (string->word "cat") (explode "cat"))
(check-expect (string->word "develop") (explode "develop"))

(define (string->word s)
  (cond [(string=? "" s) '()]
        [else (cons (substring s 0 1)
                    (string->word (substring s 1)))]))


; Word -> String
; convert w to a string

(check-expect (word->string (explode "cat")) "cat")
(check-expect (word->string (explode "develop")) "develop")

(define (word->string w)
  (cond [(empty? w) ""]
        [else (string-append (first w) (word->string (rest w)))]))


; List-of-strings -> List-of-strings
; pick out all those Strings that occur in the dictionary

(check-expect (in-dictionary (list "act" "cat" "cta" "tac" "tca" "atc"))
              (list "act" "cat"))
(check-expect (in-dictionary (list "rat" "tar" "art" "atr" "rta" "tra"))
              (list "rat" "tar" "art"))

(define (in-dictionary los)
  (cond [(empty? los) '()]
        [else (if (member? (first los) DICTIONARY-AS-LIST)
                  (cons (first los)
                        (in-dictionary (rest los)))
                  (in-dictionary (rest los)))]))


;; verify functions
; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and (member? "rat" w)
       (member? "tar" w)
       (member? "art" w)))


; List-of-words -> Boolean
(define (all-word-from-rat low)
  (and (member? (explode "rat") low)
       (member? (explode "art") low)
       (member? (explode "atr") low)
       (member? (explode "rta") low)
       (member? (explode "tra") low)
       (member? (explode "tar") low)))


; List-of-words -> Boolean
(define (all-word-from-ed low)
  (and (member? (explode "ed") low)
       (member? (explode "de") low)))