;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex422-list-to-chunks) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; functions
; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n.

(check-expect (bundle (explode "abcdefgh") 2)
              '("ab" "cd" "ef" "gh"))
(check-expect (bundle (explode "abcdefgh") 3)
              '("abc" "def" "gh"))
(check-expect (bundle '("a" "b") 3)
              '("ab"))
(check-expect (bundle '() 3) '())

(define (bundle s n)
  (map implode (list->chunk s n)))


; auxiliary functions
; [List-of Any] N -> [List-of [List-of Any]]
; bundles chunks of l into chunks, which constains given number of
; n.

(check-expect (list->chunk '(1 2 3 4) 2)
              '((1 2) (3 4)))
(check-expect (list->chunk '(s a b) 3)
              '((s a b)))
(check-expect (list->chunk '() 3) '())

(define (list->chunk l n)
  (cond [(empty? l) '()]
        [else (cons (take l n)
                    (list->chunk (drop l n) n))]))


; [List-of X] N -> [List-of X]
; keep the first n items from l is possible or everything.
(define (take l n)
  (cond [(zero? n) '()]
        [(empty? l) '()]
        [else (cons (first l)
                    (take (rest l) (sub1 n)))]))


; [List-of X] N -> [List-of X]
; remove the first n items from l if possible or everything.
(define (drop l n)
  (cond [(zero? n) l]
        [(empty? l) l]
        [else (drop (rest l) (sub1 n))]))