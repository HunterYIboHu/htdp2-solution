;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex174-encode-file) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; 1String -> String
; converts the given 1string into a three-letter numberic string

(check-expect (encode-letter "\t") (string-append "00" (codel "\t")))
(check-expect (encode-letter "a") (string-append "0" (codel "a")))
(check-expect (encode-letter "z") (codel "z"))

(define (encode-letter s)
  (cond [(< (string->int s) 10) (string-append "00" (codel s))]
        [(< (string->int s) 100) (string-append "0" (codel s))]
        [else (codel s)]))


; String -> LLS
; consume a filename and then encode text file numberically by using
; encode-letter function.

(define (encode-file n)
  (write-file (string-append "encoded-" n)
              (encode-lls (read-words/line n))))


;; auxilliary functions
; 1String -> String
; auxiliary for stating tests

(check-expect (codel "c") "99")
(check-expect (codel "z") "122")

(define (codel c)
  (number->string (string->int c)))


; LLS -> String
; use auxi/encode to encode the given LLS to numberic string.

(check-expect (encode-lls lls0) "")
(check-expect (encode-lls lls1)
              (string-append (encode-word (string->list "hello"))
                             " "
                             (encode-word (string->list "world"))
                             "\n"))

(define (encode-lls lls)
  (cond [(empty? lls) ""]
        [(cons? lls)
         (string-append (auxi/encode (first lls))
                        (if (empty? (rest lls)) "" "\n")
                        (encode-lls (rest lls)))]))


; LOS -> String
; use encode-word to help function encode-lls to encode a
; list of string into a numberic string.

(check-expect (auxi/encode line0)
              (string-append (encode-word (string->list "hello"))
                             " "
                             (encode-word (string->list "world"))))
(check-expect (auxi/encode line1) "")

(define (auxi/encode los)
  (cond [(empty? los) ""]
        [(cons? los)
         (string-append (encode-word (string->list (first los)))
                        (if (empty? (rest los)) "" " ")
                        (auxi/encode (rest los)))]))


; List-of-character -> String
; use encode-letter to help function auxi/encode, encode a
; word into numberic string.

(check-expect (encode-word (string->list "hello"))
              "104101108108111")
(check-expect (encode-word (string->list "world"))
              "119111114108100")

(define (encode-word loc)
  (cond [(empty? loc) ""]
        [(cons? loc)
         (string-append (encode-letter (string (first loc)))
                        (encode-word (rest loc)))]))


;; run program
(encode-file "ttt.txt")
