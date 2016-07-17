;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex131-name-list) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-names is one of:
; - '()
; - (cons String List-of-names)
; interpretation a List-of-names represents a list of invitees by
; last name

(define name-list-1
  (cons "胡一波"
        (cons "张全蛋"
              (cons "王尼玛"
                    (cons "白客"
                          (cons "布鲁斯"
                                '()))))))

;Explain why 
;
;(cons "1" (cons "2" '()))
;
; Answer: "1" and "2" are all String and the '() is List-of-names,
;         but 2 is a Number, not String.
;
;is an element of List-of-names and why (cons 2 '()) isn’t. 