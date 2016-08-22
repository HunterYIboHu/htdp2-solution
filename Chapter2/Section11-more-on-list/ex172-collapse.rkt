;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex172-collapse) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


;; main functions
; LLS -> String
; convert LLS to a string, the strings are separated by " ",
; the lines are separated with a "\n".

(check-expect (lls->string lls0) "")
(check-expect (lls->string lls1) "hello world\n\n")

(define (lls->string lls)
  (cond [(empty? lls) ""]
        [(cons? lls)
         (string-append (los->string (first lls)) (lls->string (rest lls)))]))


;; auxilliary functions
; LOS -> String
; convert a LOS to string, the strings in LOS are seperated by " "(#\space),
; and add an "\n" at the end.

(check-expect (los->string line0) "hello world\n")
(check-expect (los->string line1) "\n")

(define (los->string los)
  (cond [(empty? los) "\n"]
        [(cons? los)
         (string-append (first los)
                        (if (empty? (rest los)) "" " ")
              (los->string (rest los)))]))


;; run function
(write-file "ttt.dat" (lls->string (read-words/line "ttt.txt")))





