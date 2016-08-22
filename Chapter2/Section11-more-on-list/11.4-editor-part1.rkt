;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11.4-editor-part1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct editor [pre post])
; An Editor is (make-editor Lo1S Lo1S)
; An Lo1S is one of:
; - empty
; - (cons 1String Lo1S)

(define good (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all (cons "a" (cons "l" (cons "l" '()))))
(define lla (cons "l" (cons "l" (cons "a" '()))))

; data example 1:
(make-editor all good)
(check-expect (string-append (implode all) (implode good)) "allgood")

; data example 2:
(make-editor lla good)
(check-expect (string-append (implode (rev lla)) (implode good)) "allgood")


;; main functions
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
; Lo1S -> Lo1S
; reverse the 1string in the given list.

(check-expect (rev lla) all)
(check-expect (rev (explode "dog")) (explode "god"))

(define (rev los)
  (cond [(empty? los) '()]
        [(cons? los)
         (add-at-end (rev (rest los)) (first los))]))

(check-expect (rev.v2 lla) all)
(check-expect (rev.v2 (explode "dog")) (explode "god"))

(define (rev.v2 lo1s)
  (cond [(empty? lo1s) '()]
        [(cons? lo1s)
         (append (rev.v2 (rest lo1s)) (cons (first lo1s) '()))]))


; Lo1S 1String -> Lo1S
; add the given 1String as item at the end of the given Lo1S

(check-expect (add-at-end (explode "og") "d") (explode "ogd"))
(check-expect (add-at-end (explode "ll") "a") (explode "lla"))

(define (add-at-end lo1s s)
  (cond [(empty? lo1s) (cons s '())]
        [(cons? lo1s)
         (cons (first lo1s) (add-at-end (rest lo1s) s))]))

