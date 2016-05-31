;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.10-editor) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
; Editor = (make-editor String String)
; interpretation (make-editer s t) means the text in the editor is
; (string-append s t) with the cursor displayed between s and t

(define ed1 (make-editor "hello" "world"))
(define ed2 (make-editor "Hi, " "mom!"))


; graphic constants
(define CURSOR (rectangle 1 20 "solid" "red"))
(define BKG (empty-scene 200 20))
(define SIZE 16)
(define COLOR "black")


; String -> Image
; help render t into Image

(define (text/auxi t)
  (text t SIZE COLOR))


; Editor -> Image
; render the Editor to an Image, the cursor is between s and t
; examples:
(check-expect
 (render ed1)
 (overlay/align "left" "center"
                (beside (text/auxi (editor-pre ed1))
                        CURSOR
                        (text/auxi (editor-post ed1)))
                BKG))
(check-expect
 (render ed2)
 (overlay/align "left" "center"
                (beside (text/auxi (editor-pre ed2))
                        CURSOR
                        (text/auxi (editor-post ed2)))
                BKG))

(define (render ed)
  (overlay/align "left" "center"
                 (beside (text/auxi (editor-pre ed))
                         CURSOR
                         (text/auxi (editor-post ed)))
                 BKG))













