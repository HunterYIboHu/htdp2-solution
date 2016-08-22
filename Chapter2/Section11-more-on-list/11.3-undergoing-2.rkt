;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11.3-undergoing-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; data difinitions
; LOS(list of string) is one of:
; - '()
; - (cons String LOS)

(define line0 (cons "hello" (cons "world" '())))
(define line1 '())


; LLS(list of list of string) is one of:
; - '()
; - (cons LOS LLS)

(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))


; List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)


;; main functions
; LLS -> List-of-numbers
; determine the number of words on each line

(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1) (cons 2 (cons 0 '())))

(define (words-on-line lls)
  (cond [(empty? lls) '()]
        [(cons? lls) (cons (length (first lls)) (words-on-line (rest lls)))]))


; String -> List-of-numbers
; counts the number of words on each line in the given file
(define (file-statistic file-name)
  (words-on-line (read-words/line file-name)))
(file-statistic "ttt.txt")















