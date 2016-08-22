;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex211-in-dict) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; constants
(define DICTIONARY-LOCATION "en_US.dic")


;; data difinitions
; A Word is one of:
; - '() or
; - (cons 1String Word)
; interpretation a String as a list of 1Strings(letters)

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

;;;; arrangements: this function is not defined

;; auxiliary functions
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