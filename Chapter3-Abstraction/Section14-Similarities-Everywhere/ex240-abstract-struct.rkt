;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex240-abstract-struct) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct layer [stuff])


; A LStr is one of: 
; – String
; – (make-layer LStr)

(define lstr-1 (make-layer "Matthew"))
(define lstr-2 "Matthew")


; A LNum is one of: 
; – Number
; – (make-layer LNum)

(define lnum-1 (make-layer 8531))
(define lnum-2 8531)


; A [L ITEM] is one of:
; - ITEM
; - (make-layer ITEM)


; LStr is [L String]

; LNum is [L Number]
