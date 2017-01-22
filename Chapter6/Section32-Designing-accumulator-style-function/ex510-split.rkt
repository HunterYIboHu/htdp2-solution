;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex510-split) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


;; definitions
(define HEIGHT 20)
(define WIDTH 200)
(define FONT-SIZE 24)
(define FONT-COLOR "black")


;; graphic constants
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))
 
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
(define good (explode "good"))
(define all (explode "all"))
(define lla (explode "lla"))


; String String -> Editor
; consume 2 strings, the first string is pre part of e, the rest
; string is post part of e.

(check-expect (create-editor "all" "good")
              (make-editor lla good))
(check-expect (create-editor "" "all")
              (make-editor '() all))
(check-expect (create-editor "all" "")
              (make-editor lla '()))

(define (create-editor pre-s post-s)
  (make-editor (reverse (explode pre-s))
               (explode post-s)))


(define ed-1 (create-editor "ab" "cd"))
(define ed-2 (create-editor "abcd" ""))
(define ed-3 (create-editor "" "abcd"))


;; functions
; [List-of 1String] N -> Editor
; x is the x-coordinate of the mouse click.
; it produces (make-editor p s) assume:
; (1) p and s make up ed
; (2) x is larger than the image of p and smaller than the image of p
; extended with the first 1Strign on s (if any).

(check-expect (split str-1 30)
              ed-1)
(check-expect (split str-1 60)
              ed-2)
(check-expect (split str-1 10)
              ed-3)
(check-expect (split '() 10)
              (make-editor '() '()))

(define (split ed x)
  (local (; [List-of 1String] [List-of 1String] -> Editor
          ; produces the corresponding editor split by x.
          ; accumulator p represents all encountered 1String;
          ; accumulator s representes the rest string.
          (define (split/a p s)
            (cond [(or (empty? s)
                       (<= (image-width (editor-text p))
                           x
                           (image-width (editor-text `(,@p ,(first s))))))
                   (create-editor (implode p) (implode s))]
                  [else (split/a `(,@p ,(first s))
                                 (rest s))]))
          )
    (split/a '() ed)))







