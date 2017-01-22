;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex306-find-name-about) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


;; constants
(define lon-1 '("Andrew" "Anna" "Ange" "Bob" "Chathirll" "Catalog"))
(define lon-2 '("Andrew" "Anna" "Chathirll" "Catalog" "Chaloter" "Cate"))
(define lon-3 '("Anna" "Ange" "Anglela"))


; String [List-of String] -> Boolean
; determine whether any of the names on the latter are equal to or
; an extension of the former.

(check-expect (find-name "Anna" lon-1) #true)
(check-expect (find-name "Bo" lon-1) #true)
(check-expect (find-name "FatRat" lon-2) #false)

(define (find-name name lon)
  (local ((define str-len (string-length name)))
    (for/or ([item lon])
      (and (string-contains? name item)
           (string-contains? name (substring item 0 str-len))))))


; [List-of String] Number -> Boolean
; ensures that no name on given list l exceeds given length n

(check-expect (ensure-width (list "abc" "ab" "a") 4) #t)
(check-expect (ensure-width (list "abc" "ab" "a") 2) #f)

(define (ensure-width lon width)
  (for/and ([item lon])
    (<= (string-length item) width)))

