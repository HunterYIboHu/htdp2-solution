;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex175-wc) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; data difinitions
; 1String is a String whose length is 1.


; LOS(list of string) is one of:
; - '()
; - (cons String LOS)

(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
(define line2 (cons "a" (cons "little" (cons "R" (cons "language" '())))))


; LLS(list of list of string) is one of:
; - '()
; - (cons LOS LLS)

(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))
(define lls2 (cons line0 (cons line1 (cons line2 '()))))
(define lls3 (cons line2 (cons line2 (cons line0 '()))))


(define-struct file-info [num-1string num-word num-line])
; FI(file informations) is (make-file-info Number Number Number)
; (make-file-info n1 nw nl) contains the number of 1String ,
; words and lines in the specific file.


;; main function
; String -> FI
; consume the given file name and produce the file informations for it.

(check-expect (wc "text-for-ex175/lls0.txt") (process-file lls0))
(check-expect (wc "text-for-ex175/lls1.txt") (process-file lls1))
(check-expect (wc "text-for-ex175/lls3.txt") (process-file lls3))

(define (wc filename)
  (process-file (read-words/line filename)))


; LLS -> FI
; use 3 auxilliary to help make the file informations which contains
; num-1string, num-word and num-line.

(check-expect (process-file lls0) (make-file-info 0 0 0))
(check-expect (process-file lls1) (make-file-info 0 2 2))
(check-expect (process-file lls2) (make-file-info 2 6 3))
(check-expect (process-file lls3) (make-file-info 4 10 3))

(define (process-file lls)
  (make-file-info (count-1string lls)
                  (count-word lls)
                  (length lls)))


;; auxilliary functions
; LLS -> Number
; consume the given lls and produce the number of words on the list

(check-expect (count-word lls0) 0)
(check-expect (count-word lls1) 2)

(define (count-word lls)
  (cond [(empty? lls) 0]
        [(cons? lls)
         (+ (length (first lls)) (count-word (rest lls)))]))


; LLS -> Number
; consume the given lls and produce the number of 1String on the lls

(check-expect (count-1string lls0) 0)
(check-expect (count-1string lls1) 0)
(check-expect (count-1string lls2) 2)
(check-expect (count-1string lls3) 4)

(define (count-1string lls)
  (cond [(empty? lls) 0]
        [(cons? lls)
         (+ (auxi/1string (first lls)) (count-1string (rest lls)))]))


; LOS -> Number
; consume the given los and produce the number of 1string on the list.

(check-expect (auxi/1string line0) 0)
(check-expect (auxi/1string line1) 0)
(check-expect (auxi/1string line2) 2)

(define (auxi/1string los)
  (cond [(empty? los) 0]
        [(cons? los) (+ (if (= 1 (string-length (first los))) 1 0)
                        (auxi/1string (rest los)))]))


