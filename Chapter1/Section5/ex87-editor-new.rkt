;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex87-editor-new) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [text pos])
; Editor = (make-editor String Number)
; interpretation (make-editor t p) means the text is
; (substring t 0 p) and (substring t p), with cursor
; displayed between the two part.

(define ed-n (make-editor "Hello world!" 5))
(define ed-l (make-editor "Empty right side."
                          (string-length "Empty right side.")))
(define ed-r (make-editor "Empty left side." 0))