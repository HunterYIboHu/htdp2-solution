;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex72-phone) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone [area num])
; A Phone is a structure:  (make-phone Number String)
; interpretation (make-phone area num) means a phone number
; consist of area code and local phone
(define My-Phone
  (make-phone 0591 "456-9981"))


(define-struct phone# [area switch num])
; A Phone# is a structure:  (make-phone# Number String String)
; interpretation (make-phone# area switch num) a phone number
; which length is 10.
; area is between [000, 999], means the phone is in which area;
; switch is between [000, 999], means the phone switch of your
; neighborhood;
; num is between [0000, 9999], means the phone with represent to
; the neighborhood.
