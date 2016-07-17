;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex134-contains) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-names is one of:
; - '()
; - (cons String List-of-names)
; interpretation a List-of-names represents a list of invitees by last name.


; List-of-names String -> Boolean
; determine weather the name String represented is contained in
; the given list.
; examples:

(check-expect (contains? (cons "Friend"
                               (cons "Cat"
                                     (cons "Nano" '()))) "Flatt")
              #false)
(check-expect (contains? (cons "Friend"
                                      (cons "Cat"
                                            (cons "Nano"
                                                  (cons "D" '())))) "Nano")
              #true)
(check-expect (contains? '() "Orcus") #false)

(define (contains? a-list-of-names name)
  (cond [(empty? a-list-of-names) #false]
        [(cons? a-list-of-names)
         (or (string=? (first a-list-of-names) name)
             (contains? (rest a-list-of-names) name))]))