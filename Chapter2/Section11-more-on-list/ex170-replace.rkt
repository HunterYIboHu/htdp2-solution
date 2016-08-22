;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex170-replace) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct phone [area switch four])
; A Phone is a structure:
;    (make-phone Three Three Four)
; A Three is between 100 and 999
; A Four is between 1000 and 9999


; Lop (list of phones) is one of:
; - '()
; - (cons Phone Lop)
; interpretation a Lop is consist of Phone items.

(define ONE-REPLACE (cons (make-phone 713 200 3000)
                          (cons (make-phone 123 200 4320)
                                (cons (make-phone 425 203 5552)
                                      '()))))
(define ALL-REPLACE (cons (make-phone 713 100 2345)
                          (cons (make-phone 713 324 4325)
                                (cons (make-phone 713 713 4324)
                                      '()))))
(define NONE (cons (make-phone 239 239 2385)
                   (cons (make-phone 234 987 9767)
                         (cons (make-phone 712 187 3424)
                               '()))))


;; constants
(define OLD-AREA 713)
(define NEW-AREA 281)


;; main functions
; consume an-lop and produce another Lop with
; the phone area is 713 replaced with 281.

(check-expect (replace ONE-REPLACE)
              (cons (make-phone 281 200 3000)
                    (cons (make-phone 123 200 4320)
                          (cons (make-phone 425 203 5552)
                                '()))))
(check-expect (replace ALL-REPLACE)
              (cons (make-phone 281 100 2345)
                    (cons (make-phone 281 324 4325)
                          (cons (make-phone 281 713 4324)
                                '()))))
(check-expect (replace NONE) NONE)
(check-expect (replace '()) '())

(define (replace an-lop)
  (cond [(empty? an-lop) '()]
        [(cons? an-lop)
         (cons (auxi/repl (first an-lop)) (replace (rest an-lop)))]))


;; auxilliary functions
; Phone -> Phone
; if the area code is 713, replace it with 281

(check-expect (auxi/repl (make-phone 713 713 7130)) (make-phone 281 713 7130))
(check-expect (auxi/repl (make-phone 200 713 1300)) (make-phone 200 713 1300))
(check-expect (auxi/repl (make-phone 713 100 1000)) (make-phone 281 100 1000))

(define (auxi/repl p)
  (if (= OLD-AREA (phone-area p))
      (make-phone NEW-AREA (phone-switch p) (phone-four p))
      p))

