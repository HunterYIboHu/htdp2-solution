;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex334-improved-dir) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 334.
;Show how to equip a directory with two more attributes: size and readability.
;The former measures how much space the directory itself
;(as opposed to its content) consumes;
;the latter specifies whether anyone else besides the user may browse
;the content of the directory.


;; data difinitions
(define-struct dir [name content size readable])
; A Dir.v2 is a structure: 
;   (make-dir String LOFD Number Boolean)
 
; A LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String. 