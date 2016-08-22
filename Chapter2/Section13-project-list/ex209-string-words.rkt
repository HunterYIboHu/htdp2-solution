;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex209-string-words) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; A Word is one of:
; - '() or
; - (cons 1String Word)
; interpretation a String as a list of 1Strings(letters)


;; main functions
; String -> List-of-strings
; find all words that use the same letters as s

;(check-member-of (alternative-words "cat")
;                 (list "act" "cat")
;                 (list "cat" "act"))
;(check-satisfied (alternative-words "rat") all-words-from-rat?)

;(define (alternative-words s)
;  (in-dictionary
;   (words->strings (arrangements (string->word s)))))


;; auxiliary functions
; List-of-words -> List-of-strings
; turn all Words in low into Strings
(define (words->strings low) '())


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
(define (in-dictionary los) '())


;; verify functions
; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and (member? "rat" w)
       (member? "tar" w)
       (member? "art" w)))