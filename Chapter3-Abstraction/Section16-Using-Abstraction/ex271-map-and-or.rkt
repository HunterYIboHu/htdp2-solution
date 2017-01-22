;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex271-map-and-or) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #f)))
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
  (local ((define strlen (string-length name))
          ; String -> Boolean
          ; determine whether the given name is equal to or an
          ; extension of the specific name.
          (define (name=? n)
            (cond [(< (string-length n) strlen) #false]
                  [(string=? name (substring n 0 strlen)) #true]
                  [else #false])))
    (ormap name=? lon)))


; [List-of String] -> Boolean
; checks all names on a list of names starts with "a" or "A"

(check-expect (check-a lon-1) #false)
(check-expect (check-a lon-2) #false)
(check-expect (check-a lon-3) #true)

(define (check-a lon)
  (local ((define a '("a" "A"))
          ; String -> Boolean
          ; check if the given name starts with "a" or "A"
          (define (start-with-a? n)
            (member? (substring n 0 1) a)))
    (andmap start-with-a? lon)))


;; Q1: Should you use ormap or andmap to define a function that
;; ensures that no name on some list exceeds some given width?
;;
;; A1: I think it's not necessary, for the check is not universal, just add it
;; to where it need, it's enough.