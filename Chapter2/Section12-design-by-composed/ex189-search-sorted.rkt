;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex189-unfinished) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; SLON (sorted list of numbers) is one of:
; - '()
; - (insert Number SLON)


;; main functions
; Number Sorted-List-of-numbers -> Boolean
; search a given number in the SLON, the list is sorted descending.

(check-expect (search-sorted 10 (range 8 0 -2)) #f)
(check-expect (search-sorted 10 (range 20 8 -2)) #t)
(check-expect (search-sorted 14 (range 40 0 -3)) #f)
(check-expect (search-sorted 10 '()) #f)

(define (search-sorted n aslon)
  (cond [(empty? aslon) #false]
        [(> n (first aslon)) #false]
        [(= n (first aslon)) #true]
        [else (search-sorted n (rest aslon))]))

