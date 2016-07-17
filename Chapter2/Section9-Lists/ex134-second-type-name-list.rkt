;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex134-second-type-name-list) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-names is one of:
; - '()
; - (cons String List-of-names)
; interpretation a List-of-names represents a list of invitees by last name.


; List-of-names -> Boolean
; determine whether "Flatt" occurs on a-list-of-names
; examples:

(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Findler" '())) #false)
(check-expect (contains-flatt? (cons "Flatt" '())) #true)
(check-expect (contains-flatt? (cons "Mur" (cons "Fish" (cons "Find" '()))))
              #false)
(check-expect (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
              #true)

(define (contains-flatt? a-list-of-names)
  (cond [(empty? a-list-of-names) #false]
        [(cons? a-list-of-names)
         (cond [(string=? (first a-list-of-names) "Flatt") #true]
               [else (contains-flatt? (rest a-list-of-names))])]))

; Reason:
; or and cond-else all evaluate the first expression first, if it produces
; #true, the result is #true; else it will evaluate the second expression.
;
; But I prefer the first form that using keyword "or".The less code and the
; clearer meaning is what I concerned.








