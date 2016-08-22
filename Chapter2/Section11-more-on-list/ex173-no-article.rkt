;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex173-no-article) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; data difinitions
; LOS(list of string) is one of:
; - '()
; - (cons String LOS)

(define line0 (cons "hello" (cons "a" (cons "world" '()))))
(define line1 '())
(define line2 (cons "the" (cons "a" (cons "an" (cons "the" '())))))


; LLS(list of list of string) is one of:
; - '()
; - (cons LOS LLS)

(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))
(define lls2 (cons line0 (cons line1 (cons line2 '()))))


;; constants
(define ARTICLE (cons "a" (cons "an" (cons "the" '()))))


;; main functions
; String -> File
; consume the file name n, and removes the articles in the content.
; then write the result to file named "no-articles-" with n.

(define (no-article n)
  (write-file (string-append "no-article-" n)
              (file-processor (read-words/line n))))


;; auxilliary functions
; LLS -> String
; consume a lls, and remove the articles in the content, and then convert
; it into string.

(check-expect (file-processor lls0) "")
(check-expect (file-processor lls1) "hello world\n")
(check-expect (file-processor lls2) "hello world\n\n")

(define (file-processor lls)
  (cond [(empty? lls) ""]
        [(cons? lls)
         (string-append (remove-article (first lls))
                        (if (empty? (rest lls)) "" "\n")
                        (file-processor (rest lls)))]))


; LOS -> String
; consume a los, and remove the articles in the content, and then convert
; it into string.

(check-expect (remove-article line0) "hello world")
(check-expect (remove-article line1) "")
(check-expect (remove-article line2) "")

(define (remove-article los)
  (cond [(empty? los) ""]
        [(cons? los)
         (string-append (if (member (first los) ARTICLE)
                            ""
                            (string-append (first los)
                                           (if (empty? (rest los)) "" " ")))
                        (remove-article (rest los)))]))


;; run program
(no-article "ttt.txt")