;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex146-sorted) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 146. Design sorted>?.
; The function consumes a NEList-of-temperatures.
; It produces #true if the temperatures are sorted in descending order,
; that is, if the second is smaller than the first,
; the third smaller than the second, and so on.
; Otherwise it produces #false.


; ---


; A CTemperature is a Number greater or equal to -273

; A NEList-of-temperatures is one of:
; - (cons CTemperature '())
; - (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of measured temperatures


; NEList-of-temperatures -> Boolean
; determine weather the temperatures are sorted in descending order,
; on this case, it produce #true; otherwise it produce #false.
; examples:

(check-expect (sorted>? (cons 12 (cons 10 (cons 8 '())))) #true)
(check-expect (sorted>? (cons 12 (cons 12 (cons 39 '())))) #false)
(check-expect (sorted>? (cons 12 '())) #true)

(define (sorted>? anelot)
  (cond [(empty? (rest anelot)) #t]
        [(cons? (rest anelot))
         (and (> (first anelot)
                 (first (rest anelot)))
              (sorted>? (rest anelot)))]))

