;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex80-time-second) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; pyhsics constants
(define HOUR 3600)
(define MINUTE 60)

; - hour is between 0 and 24 => [0, 24]
; - min is between 0 and 60 => [0, 60]
; - sec is between 0 and 60 => [0, 60]
; interpretation Point-in-time represent a time
; since midnight
(define-struct time [hour minute second])
; Time is (make-time Number Number Number)

(define ex1 (make-time 12 30 2))
(define ex2 (make-time 0 5 1))


; hour min sec -> Number
; consume 3 Number then retuen the seconds represent by them

(define (time->seconds/auxi hour min sec)
  (+ (* hour HOUR) (* min MINUTE) sec))


; Time -> Number
; determine the Second between tm and midnight
; examples:
(check-expect (time->seconds ex1)
              (time->seconds/auxi (time-hour ex1)
                                  (time-minute ex1)
                                  (time-second ex1)))
(check-expect (time->seconds ex2)
              (time->seconds/auxi (time-hour ex2)
                                  (time-minute ex2)
                                  (time-second ex2)))

(define (time->seconds tm)
  (time->seconds/auxi (time-hour tm)
                      (time-minute tm)
                      (time-second tm)))

(time->seconds ex1)

