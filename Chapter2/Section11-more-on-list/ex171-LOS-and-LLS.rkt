;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11.3-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; data difinitions
; LOS(list of string) is one of:
; - '()
; - (cons String LOS)

(read-lines "ttt.txt")
(check-expect (read-lines "blank.txt") '())
(check-expect (read-lines "newline.txt") (cons "" '()))

(read-words "ttt.txt")
(check-expect (read-lines "blank.txt") '())
(check-expect (read-lines "newline.txt") (cons "" '()))


; LLS(list of list of string) is one of:
; - '()
; - (cons LOS LLS)

(read-words/line "ttt.txt")
(check-expect (read-words/line "blank.txt") '())
(check-expect (read-words/line "newline.txt") (cons '() '()))
;; "blank.txt" is a plain text without any content.