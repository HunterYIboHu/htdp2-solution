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


; graphic constants
(define CURSOR (rectangle 1 20 "solid" "red"))
(define BKG (empty-scene 200 20))
(define SIZE 16)
(define COLOR "black")


; Editor -> Image
; render the text part of Editor. The text seperate into 2
; parts, the left is (substring t 0 p); the right is
; (substring t p).
; examples:
(check-expect (render ed-n)
              (overlay/align "left" "center"
                             (beside (text (substring (editor-text ed-n) 0 (editor-pos ed-n)) SIZE COLOR)
                                     CURSOR
                                     (text (substring (editor-text ed-n) (editor-pos ed-n)) SIZE COLOR))
                             BKG))

(define (render ed) ed)