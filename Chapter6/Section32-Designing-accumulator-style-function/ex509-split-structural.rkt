;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex509-split-structural) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; definitions
(define FONT-SIZE 24)
(define FONT-COLOR "black")
 
; [List-of 1String] -> Image
; render a string as an image for the editor 
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))
 
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor [List-of 1String] [List-of 1String])
; interpretation if (make-editor p s) is the state of 
; an interactive editor, (reverse p) corresponds to
; the text to the left of the cursor and s to the
; text on the right 


;; data examples
(define str-1 (explode "abcd"))

(define ed-1 (make-editor (reverse (explode "ab"))
                          (explode "cd")))
(define ed-2 (make-editor (reverse (explode "abcd")) '()))
(define ed-3 (make-editor '() (explode "abcd")))


;; functions
; [List-of 1String] N -> Editor
; x is the x-coordinate of the mouse click.
; it produces (make-editor p s) assume:
; (1) p and s make up ed
; (2) x is larger than the image of p and smaller than the image of p
; extended with the first 1Strign on s (if any).

(check-expect (split-structural str-1 30)
              ed-1)
(check-expect (split-structural str-1 60)
              ed-2)
(check-expect (split-structural str-1 10)
              ed-3)
(check-expect (split-structural '() 10)
              (make-editor '() '()))

(define (split-structural ed x)
  (local (; [List-of 1String] -> [List-of 1String]
          (define (find-pre los)
            (cond [(empty? los) '()]
                  [(<= (image-width (editor-text (rest los)))
                       x
                       (image-width (editor-text los)))
                   (rest los)]
                  [else (find-pre (rest los))]))
          ; [List-of 1String] -> [List-of 1String]
          (define (find-post los)
            ())
          )
    (make-editor (find-pre (reverse ed))
                 (find-post ed))))







