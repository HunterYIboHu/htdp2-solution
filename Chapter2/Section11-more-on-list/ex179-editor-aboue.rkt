;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex179-editor-aboue) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


;; constants
(define HEIGHT 20)
(define WIDTH 200)
(define FONT-SIZE 16)
(define FONT-COLOR "black")

; graphical constants
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))


;; data difinitions
(define-struct editor [pre post])
; An Editor is (make-editor Lo1S Lo1S)
; An Lo1S is one of:
; - empty
; - (cons 1String Lo1S)
; interpretation the field pre shall be a revesed Lo1S.

(define good (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all (cons "a" (cons "l" (cons "l" '()))))
(define lla (cons "l" (cons "l" (cons "a" '()))))


;; important functions
; String String -> Editor
; comsume two strings, the first string is pre part of the
; e, and the rest string is post part of the e.

(check-expect (create-editor "all" "good") (make-editor (explode "lla")
                                                        (explode "good")))
(check-expect (create-editor "best" "") (make-editor (explode "tseb") '()))
(check-expect (create-editor "" "") (make-editor '() '()))

(define (create-editor pre-s post-s)
  (make-editor (rev (explode pre-s)) (explode post-s)))


;; auxilliary functions
; Editor -> Editor
; insert the 1String k between pre and post

(check-expect (editor-ins (make-editor '() '()) "e")
              (make-editor (cons "e" '()) '()))
(check-expect (editor-ins (make-editor (cons "d" '())
                                       (cons "f" (cons "g" '()))) "e")
              (make-editor (cons "e" (cons "d" '()))
                           (cons "f" (cons "g" '()))))

(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed)) (editor-post ed)))


; Editor -> Editor
; moves the cursor position one 1String left, if possible

(check-expect (editor-lft (make-editor '() (cons "n" (cons "o" '()))))
              (make-editor '() (cons "n" (cons "o" '()))))
(check-expect (editor-lft (make-editor (cons "c"(cons "b" (cons "a" '())))
                                       (cons "d" (cons "e" '()))))
              (make-editor (cons "b" (cons "a" '()))
                           (cons "c" (cons "d" (cons "e" '())))))

(define (editor-lft ed)
  (cond [(empty? (editor-pre ed)) ed]
        [(cons? (editor-pre ed))
         (make-editor (rest (editor-pre ed))
                      (cons (first (editor-pre ed)) (editor-post ed)))]))


; Editor -> Editor
; moves the cursor position one 1String right, if possible

(check-expect (editor-rgt (make-editor (cons "n" (cons "o" '())) '()))
              (make-editor (cons "n" (cons "o" '())) '()))
(check-expect (editor-rgt (make-editor (cons "b" (cons "a" '()))
                                       (cons "c" (cons "d" '()))))
              (make-editor (cons "c" (cons "b" (cons "a" '())))
                           (cons "d" '())))

(define (editor-rgt ed)
  (cond [(empty? (editor-post ed)) ed]
        [(cons? (editor-post ed))
         (make-editor (cons (first (editor-post ed)) (editor-pre ed))
                      (rest (editor-post ed)))]))


; Editor -> Editor
; deletes one 1String to the left of the cursor, if possible

(check-expect (editor-del (make-editor '() (cons "n" (cons "o" '()))))
              (make-editor '() (cons "n" (cons "o" '()))))
(check-expect (editor-del (make-editor (cons "c" (cons "b" (cons "a" '())))
                                       (cons "d" (cons "e" '()))))
              (make-editor (cons "b" (cons "a" '()))
                           (cons "d" (cons "e" '()))))

(define (editor-del ed)
  (cond [(empty? (editor-pre ed)) ed]
        [(cons? (editor-pre ed))
         (make-editor (rest (editor-pre ed)) (editor-post ed))]))


; Lo1S -> Lo1S
; reverse the 1string in the given list.

(check-expect (rev lla) all)
(check-expect (rev (explode "dog")) (explode "god"))

(define (rev los)
  (cond [(empty? los) '()]
        [(cons? los)
         (add-at-end (rev (rest los)) (first los))]))


; Lo1S 1String -> Lo1S
; add the given 1String as item at the end of the given Lo1S

(check-expect (add-at-end (explode "og") "d") (explode "ogd"))
(check-expect (add-at-end (explode "ll") "a") (explode "lla"))

(define (add-at-end lo1s s)
  (cond [(empty? lo1s) (cons s '())]
        [(cons? lo1s)
         (cons (first lo1s) (add-at-end (rest lo1s) s))]))


;; Questions
;; Q1 Why editor-ins can perform the insertion?
;; A1 Because the "pre" field of Editor is reversed, and the inserted letter
;; will add in front of the origin string. That what's function editor-ins
;; do.