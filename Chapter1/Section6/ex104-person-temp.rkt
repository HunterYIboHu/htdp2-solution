;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex104-person-temp) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct student [fst-name lst-name gpa])

(define-struct professor [fst-name lst-name status])

(define-struct staff [fst-name lst-name salary-group])

; A Person is one of:
; - student
; - professor
; - staff
; interpretation represents the person in the university.

; gather-info
; Person -> String
; consume a Person, then get the information in it.
; examples:


(define (gather-info p)
  (cond [(student? p)
         (string-append (student-fst-name p)
                        " " (student-lst-name p)
                        "'s gpa is " (student-gpa p))]
        [(professor? p)
         (string-append (professor-fst-name p)
                        " " (professor-lst-name p)
                        "'s status is " (professor-status p))]
        [(staff? p)
         (string-append (staff-fst-name p)
                        " " (staff-lst-name p)
                        "'s salary group is"
                        (staff-salary-group p))]))