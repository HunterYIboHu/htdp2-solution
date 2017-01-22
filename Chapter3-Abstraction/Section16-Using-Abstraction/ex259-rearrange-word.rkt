;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex250-rearrange-word) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; constants
(define DICTIONARY-LOCATION "en_US.dic")


;; data difinitions
; A Word is [List-of 1String]

(define ED (explode "ed"))
(define RAT (explode "rat"))

(define RAT-L (list (explode "art") (explode "rat") (explode "tar")
                    (explode "atr") (explode "rta") (explode "tra")))
(define ED-L (list (explode "ed") (explode "de")))

; A Dictionary is a [List-of String]
;(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))
;(define DICTIONARY-AS-LIST-S (read-lines SMALL-DIC))
(define SMALL-DICTIONARY (list "art" "rat" "tar" "act" "cat"))


; A Letter is one of the following 1Strings:
; - "a"
; - ...
; - "z"
; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))


;; functions
; Word -> [List-of Word]
; creates all rearrangements of the letters in w

(check-satisfied (arrangements ED) all-word-from-ed)
(check-satisfied (arrangements RAT) all-word-from-rat)

(define (arrangements w)
  (local (; 1String Word Number -> [List-of Word]
          ; produce a list of word with the first argument
          (define (consist-word l w pos)
            (explode (string-append (substring (implode w) 0 pos)
                                    l
                                    (substring (implode w) pos))))
          ; 1String Word -> [List-of Word]
          ; produces a list of word with the first argument inserted at the begining,
          ; between all letters, and at the end of the given Word.
          (define (insert-everywhere/in-one-word l w pos)
            (cond [(> pos (length w)) '()]
                  [else (cons (consist-word l w pos)
                              (insert-everywhere/in-one-word l w (add1 pos)))]))
          ; 1String [List-of Word] -> [List-of Word]
          ; produces a list of words with the first argument inserted at the
          ; beginning, between all letters, and at the end of all words of the given
          ; list.
          (define (insert-everywhere/in-all-words l low)
            (cond [(empty? low) '()]
                  [else (append (insert-everywhere/in-one-word l (first low) 0)
                                (insert-everywhere/in-all-words l (rest low)))])))
         (cond [(empty? w) (list '())]
               [else (insert-everywhere/in-all-words (first w)
                                                     (arrangements (rest w)))])))


;; verify functions
; [List-of Word] -> Boolean
(define (all-word-from-rat low)
  (and (member? (explode "rat") low)
       (member? (explode "art") low)
       (member? (explode "atr") low)
       (member? (explode "rta") low)
       (member? (explode "tra") low)
       (member? (explode "tar") low)))


; [List-of Word] -> Boolean
(define (all-word-from-ed low)
  (and (member? (explode "ed") low)
       (member? (explode "de") low)))








