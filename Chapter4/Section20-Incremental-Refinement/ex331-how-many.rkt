;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex331-how-many) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1 Dir.v1)
 
; A File.v1 is a String.


;; constants
(define TS '("read!"
             ("part1" "part2" "part3")
             (("hang" "draw")
              ("read!"))))


;; functions
; Dir.v1 -> Number
; produces the number of files contains in the given dir.

(check-expect (how-many TS) 7)
(check-expect (how-many '()) 0)
(check-expect (how-many '((("world")))) 1)

(define (how-many dir)
  (cond [(empty? dir) 0]
        [(string? dir) 1]
        [else (+ (how-many (first dir))
                 (how-many (rest dir)))]))

