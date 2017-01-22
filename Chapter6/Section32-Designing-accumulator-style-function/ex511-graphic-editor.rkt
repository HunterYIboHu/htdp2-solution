;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex511-graphic-editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


;; definitions
(define MAX 14)

(define HEIGHT 40)
(define WIDTH 200)
(define FONT-SIZE 24)
(define FONT-COLOR "black")


;; graphic constants
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))
 
; [List-of 1String] -> Image
; render a string as an image for the editor 
(define (editor-text s)
  (text/font (implode s) FONT-SIZE FONT-COLOR
             "Lucida Console" 'modern 'normal 'normal #f))
 
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
; String -> Editor
; launches the editor given some initial string

(define (main s)
  (big-bang (create-editor s "")
            [on-key editor-kh]
            [to-draw editor-render]
            [on-mouse editor-mh]))


; Editor KeyEvent -> Editor
; deals with a key event, given some editor

(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect (editor-kh (create-editor "cd" "fgh") "e")
              (create-editor "cde" "fgh"))
(check-expect (editor-kh (create-editor "" "no change") "\b")
              (create-editor "" "no change"))
(check-expect (editor-kh (create-editor "cd" "efg") "\b")
              (create-editor "c" "efg"))
(check-expect (editor-kh (create-editor "" "no change") "left")
              (create-editor "" "no change"))
(check-expect (editor-kh (create-editor "cd" "efg") "left")
              (create-editor "c" "defg"))
(check-expect (editor-kh (create-editor "no change" "") "right")
              (create-editor "no change" ""))
(check-expect (editor-kh (create-editor "cd" "efg") "right")
              (create-editor "cde" "fg"))
(check-expect (editor-kh (create-editor "no" "change") "\t")
              (create-editor "no" "change"))
(check-expect (editor-kh (create-editor "no" "change") "\r")
              (create-editor "no" "change"))
(check-expect (editor-kh (create-editor "no" "change") "shift")
              (create-editor "no" "change"))

(define (editor-kh ed ke)
  (cond [(key=? ke "left") (editor-lft ed)]
        [(key=? ke "right") (editor-rgt ed)]
        [(key=? ke "\b") (editor-del ed)]
        [(ormap (lambda (s) (key=? ke s)) '("\r" "\t")) ed]
        [(= 1 (string-length ke)) (editor-ins ed ke)]
        [else ed]))


; Editor -> Editor
; moves the cursor position one 1String left, if possible

(check-expect (editor-lft (create-editor "" "abc"))
              (create-editor "" "abc"))
(check-expect (editor-lft (create-editor "" ""))
              (create-editor "" ""))
(check-expect (editor-lft (create-editor "a" "bc"))
              (create-editor "" "abc"))
(check-expect (editor-lft (create-editor "abc" ""))
              (create-editor "ab" "c"))

(define (editor-lft ed)
  (local ((define pre (editor-pre ed))
          (define post (editor-post ed)))
    (cond [(empty? pre) ed]
          [else (make-editor (rest pre)
                             (cons (first pre) post))])))


; Editor -> Editor
; moves the cursor position one 1String right, if possible

(check-expect (editor-rgt (create-editor "abc" ""))
              (create-editor "abc" ""))
(check-expect (editor-rgt (create-editor "" ""))
              (create-editor "" ""))
(check-expect (editor-rgt (create-editor "ab" "c"))
              (create-editor "abc" ""))
(check-expect (editor-rgt (create-editor "" "abc"))
              (create-editor "a" "bc"))

(define (editor-rgt ed)
  (local ((define pre (editor-pre ed))
          (define post (editor-post ed)))
    (cond [(empty? post) ed]
          [else (make-editor (cons (first post) pre)
                             (rest post))])))


; Editor -> Editor
; remove one item from ed's pre field, if any.

(check-expect (editor-del (create-editor "" "abc"))
              (create-editor "" "abc"))
(check-expect (editor-del (create-editor "" ""))
              (create-editor "" ""))
(check-expect (editor-del (create-editor "abc" "ac"))
              (create-editor "ab" "ac"))
(check-expect (editor-del (create-editor "abc" ""))
              (create-editor "ab" ""))

(define (editor-del ed)
  (local ((define pre (editor-pre ed))
          (define post (editor-post ed)))
    (cond [(empty? pre) ed]
          [else (make-editor (rest pre) post)])))


; Editor KeyEvent -> Editor
; produces the new editor with pre field add ke as item,
; if the length of editor-pre and editor-post adds less than MAX.

(check-expect (editor-ins (create-editor "all" "a") "s")
              (create-editor "alls" "a"))
(check-expect (editor-ins (create-editor "" "nothing") "q")
              (create-editor "q" "nothing"))
(check-expect (editor-ins (make-editor (make-list MAX "a") '()) "a")
              (make-editor (make-list MAX "a") '()))

(define (editor-ins ed ke)
  (local ((define pre (editor-pre ed))
          (define post (editor-post ed))
          (define text-length (foldr + 0 (map length `(,pre ,post)))))
    (cond [(> MAX text-length) (make-editor (cons ke pre) post)]
          [else ed])))


; Editor -> Image
; render an editor as an image of the two texts separated by the cursor

(check-expect (editor-render (create-editor "pre" "post"))
              (place-image/align (beside (editor-text (explode "pre"))
                                         CURSOR
                                         (editor-text (explode "post")))
                                 1 1 "left" "top" MT))

(define (editor-render e)
  (place-image/align (beside (editor-text (reverse (editor-pre e)))
                             CURSOR
                             (editor-text (editor-post e)))
                     1 1 "left" "top" MT))


; Editor N N MouseEvent -> Editor
; compute the current position of cursor.

(check-expect (editor-mh ed-2 30 100 "button-down")
              ed-1)
(check-expect (editor-mh ed-2 60 100 "button-down")
              ed-2)
(check-expect (editor-mh ed-2 10 100 "button-down")
              ed-3)

(define (editor-mh ed x y me)
  (if (mouse=? me "button-down")
      (split (append (reverse (editor-pre ed))
                     (editor-post ed))
             x)
      ed))


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


;; launch
(main "hello!")