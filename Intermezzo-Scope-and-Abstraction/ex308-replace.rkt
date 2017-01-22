;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex308-replace) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


;; data difinitions
(define-struct phone [area switch four])
; A Phone is a structure:
;    (make-phone Three Three Four)
; A Three is between 100 and 999
; A Four is between 1000 and 9999


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


;; functions
; [List-of Phone] -> [List-of Phone]
; consume an-lop and produce another Lop with
; the phone area is 713 replaced with 281.

(check-expect (replace ONE-REPLACE)
              `(,(make-phone 281 200 3000) ,(make-phone 123 200 4320)
                                           ,(make-phone 425 203 5552)))
(check-expect (replace ALL-REPLACE)
              `(,(make-phone 281 100 2345) ,(make-phone 281 324 4325)
                                           ,(make-phone 281 713 4324)))
(check-expect (replace NONE) NONE)
(check-expect (replace '()) '())

(define (replace lop)
  (map (local ((define NEW-AREA 281))
         (lambda (p)
           (match p
             [(phone 713 s f) (make-phone NEW-AREA s f)]
             [x x])))
       lop))

