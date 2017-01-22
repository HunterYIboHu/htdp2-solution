;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex452-add-proper-statements) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data definitions
; A File is one of: 
; – '()
; – (cons "\n" File)
; – (cons 1String File)
; interpretation represent the content of a file 
; "\n" is the newline character

; A Line is a [List-of 1String].


;; constants
(define NEWLINE "\n")

(define line-1 '("a" "b" "c"))
(define line-2 '("d" "e"))
(define line-3 '("f" "g" "h"))

(define file-1 (list "a" "b" "c" "\n"
                     "d" "e" "\n"
                     "f" "g" "h" "\n"))
(define file-2 `(,line-1 ,line-2 ,line-3))


;; functions
; File -> [List-of Line]
; converts a file into a list of lines.

(check-expect (file->list-of-lines (list "a" "b" "c" "\n"
                                         "d" "e" "\n"
                                         "f" "g" "h" "\n"))
              (list '("a" "b" "c")
                    '("d" "e")
                    '("f" "g" "h")))
(check-expect (file->list-of-lines '())
              '())
(check-expect (file->list-of-lines '("\n"))
              '(()))
(check-expect (file->list-of-lines '("\n" "\n"))
              '(() ()))

(define (file->list-of-lines afile)
  (cond [(empty? afile) '()]
        [else (cons (first-line afile)
                    (file->list-of-lines (remove-first-line afile)))]))


;; auxiliary functions
; File -> Line
; produces the line contains all 1String unless encounter "\n"
; or the end of list.

(check-expect (first-line file-1) line-1)
(check-expect (first-line '()) '())
(check-expect (first-line '("\n")) '())

(define (first-line afile)
  (cond [(or (empty? afile)
             (string=? NEWLINE (first afile))) '()]
        [else (cons (first afile)
                    (first-line (rest afile)))]))


; File -> File
; produces the file exclusive all 1String is included in the first line.

(check-expect (remove-first-line file-1)
              (list "d" "e" "\n"
                    "f" "g" "h" "\n"))
(check-expect (remove-first-line '()) '())
(check-expect (remove-first-line '("\n")) '())
(check-expect (remove-first-line '("\n" "\n")) '("\n"))

(define (remove-first-line afile)
  (cond [(empty? afile) '()]
        [(string=? NEWLINE (first afile)) (rest afile)]
        [else (remove-first-line (rest afile))]))

