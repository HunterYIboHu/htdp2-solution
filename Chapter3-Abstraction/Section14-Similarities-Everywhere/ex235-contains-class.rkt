;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex235-contains-class) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; main functions
; Los -> Boolean
; determine whether l contains "atom"

(check-expect (contains-atom? '("cat" "dog" "mouse")) #false)
(check-expect (contains-atom? '("cat" "dog" "mouse" "atom")) #true)

(define (contains-atom? l)
  (contains? "atom" l))


; Los -> Boolean
; determine whether l contains "basic"

(check-expect (contains-basic?  '("cat" "dog" "mouse")) #false)
(check-expect (contains-basic?  '("cat" "dog" "mouse" "basic")) #true)

(define (contains-basic? l)
  (contains? "basic" l))


; Los -> Boolean
; determine whether l contains "zoo"

(check-expect (contains-zoo? '("cat" "dog" "mouse")) #false)
(check-expect (contains-zoo? '("cat" "dog" "zoo")) #true)

(define (contains-zoo? l)
  (contains? "zoo" l))


;; auxiliary functions
; String Los -> Boolean
; determine whether l contains the string s

(check-expect (contains? "cat" '("cat" "dog" "mouse")) #true)
(check-expect (contains? "dog"  '("cat" "dog" "mouse")) #true)
(check-expect (contains? "horse" '("cat" "dog" "mouse")) #false)

(define (contains? s l)
  (cond [(empty? l) #false]
        [else (or (string=? (first l) s)
                  (contains? s (rest l)))]))