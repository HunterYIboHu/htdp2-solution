;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex187-sort-email) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct email [from date message])
; A Email Message is a structure:
;    (make-email String Number String)
; interpretation (make-email f d m) represents text m sent by
; f, d seconds after the beginning of time.

(define em1 (make-email "Matthew" 10000 "I miss you."))
(define em2 (make-email "Dr.John" 15000 "Send your homework to me soon."))
(define em3 (make-email "Dr.John" 25000 "Hurry up!"))
(define em4 (make-email "Matthew" 30000 "You make me angry!"))
(define em5 (make-email "Jay" 2000 "Listen to me!~"))

; LOE (list of email message) is one of:
; - '()
; - (cons Email-Message LOE)
; interpretation the list contains emails.

(define loe1 '())
(define loe2 (list em1))
(define loe3 (list em1 em2 em3 em4))
(define loe4 (list em3 em1 em4 em2))


;; main functions
; LOE -> LOE
; produces a sorted version of l, the list is sorted by date, in ascending
; order (which email's date is smaller than others can be the first).
; DATE: em1 < em2 < em3 < em4

(check-expect (sort<date '()) '())
(check-expect (sort<date (list em1)) (list em1))
(check-expect (sort<date (list em1 em2 em3 em4))
              (list em1 em2 em3 em4))
(check-expect (sort<date (list em3 em1 em4 em2))
              (list em1 em2 em3 em4))

(define (sort<date aloe)
  (cond [(empty? aloe) '()]
        [else (insert<date (first aloe) (sort<date (rest aloe)))]))


; LOE -> LOE
; produce a sorted version of l, the list is sorted by name, in ascending
; order (which email's from is smaller than others can be the first).
; NAME: "Dr.John" < "Jay" < "Matthew"
; FROM: em2 == em3 < em5 < em1 == em4

(check-expect (sort<from '()) '())
(check-expect (sort<from (list em2)) (list em2))
(check-expect (sort<from (list em5 em2 em1)) (list em2 em5 em1))
(check-expect (sort<from (list em2 em5 em1)) (list em2 em5 em1))

(define (sort<from aloe)
  (cond [(empty? aloe) '()]
        [else (insert<from (first aloe) (sort<from (rest aloe)))]))


;; auxiliary functions
; Email LOE -> LOE
; insert an email to the list in the ascending order .
; the input LOE is in ascending order.
; (which email's date is smaller than others can be the first)

(check-expect (insert<date em2 '()) (list em2))
(check-expect (insert<date em1 (list em2)) (list em1 em2))
(check-expect (insert<date em3 (list em2)) (list em2 em3))
(check-expect (insert<date em3 (list em1 em2 em4)) (list em1 em2 em3 em4))

(define (insert<date em aloe)
  (cond [(empty? aloe) (list em)]
        [else (if (<= (email-date em)
                      (email-date (first aloe)))
                  (cons em aloe)
                  (cons (first aloe)
                        (insert<date em (rest aloe))))]))


; Email LOE -> LOE
; insert an email to the list in the ascending order.
; the input LOE is in ascending order.
; (which email's from is smaller than others can be the first)
; FROM: em2 == em3 < em5 < em1 == em4

(check-expect (insert<from em5 '()) (list em5))
(check-expect (insert<from em5 (list em2)) (list em2 em5))
(check-expect (insert<from em5 (list em1)) (list em5 em1))
(check-expect (insert<from em5 (list em2 em1 em4)) (list em2 em5 em1 em4))

(define (insert<from em aloe)
  (cond [(empty? aloe) (list em)]
        [else (if (string<? (email-from em)
                            (email-from (first aloe)))
                  (cons em aloe)
                  (cons (first aloe)
                        (insert<from em (rest aloe))))]))

