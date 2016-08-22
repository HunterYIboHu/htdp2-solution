;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex242-occurs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; A [List-of ITEM] is one of: 
; – '() 
; – (cons ITEM [List-of ITEM])


; A [Maybe X] is one of: 
; – #false 
; – X


; [Maybe String] is one of:
; - #false
; - String
; interpretation a value is a String or #false.


; [Maybe [List-of String]] is one of:
; - #false
; - [List-of String]
; interpretation a value is a [List-of String] or #false.


; [List-of [Maybe String]] is one of:
; - '()
; - (cons [Maybe String] [List-of [Maybe String]])
; interpretation a list contains value represents [Maybe String].


;; main functions
; String [List-of String] -> [Maybe [List-of String]]
; returns the remainder of los starting with s 
; #false otherwise 

(check-expect (occurs "a" (list "b" "a" "d" "e"))
              (list "d" "e"))
(check-expect (occurs "a" (list "b" "c" "d")) #f)

(define (occurs s los)
  (cond [(empty? los) #false]
        [else (if (string=? s (car los))
                  (cdr los)
                  (occurs s (cdr los)))]))


;; Questions
;; What does the above function signature mean?
;; A: it means the functions consume String and List-of-strings, produces
;; List-of-strings or #false.












