;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex180-editor-text) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define FONT-SIZE 16)
(define FONT-COLOR "black")
(define EMPTY (text "" FONT-SIZE FONT-COLOR))

; Lo1s -> Image
; renders a list of 1Strings as a text image.

(check-expect (editor-text (cons "p" (cons "o" (cons "s" (cons "t" '())))))
              (text "post" FONT-SIZE FONT-COLOR))
(check-expect (editor-text (cons "e" (cons "r" (cons "p" '()))))
              (text "erp" FONT-SIZE FONT-COLOR))

(define (editor-text s)
  (cond [(empty? s) EMPTY]
        [(cons? s)
         (beside (text (first s) FONT-SIZE FONT-COLOR)
                 (editor-text (rest s)))]))