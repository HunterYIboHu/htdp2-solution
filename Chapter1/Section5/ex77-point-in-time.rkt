;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex77-point-in-time) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Time is (make-time Number Number Number)
; - hour is between 0 and 24 => [0, 24]
; - min is between 0 and 60 => [0, 60]
; - sec is between 0 and 60 => [0, 60]
; interpretation Point-in-time represent a time
; since midnight
(define-struct time [hour minute second])
