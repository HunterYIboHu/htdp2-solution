;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex116-light) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond [(string? x) (or (string=? "red" x)
                         (string=? "yellow" x)
                         (string=? "green" x))]
        [else #false]))


; Any Any -> Boolean
; are the two values elements of TrafficLight collection.
; if so, are they equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-error (light=? "yellow" "wrong")
             "traffic light expected, given : 2nd parameter is other value")
(check-error (light=? 11 12)
             "traffic light expected, given : two other value")
(check-error (light=? 11 "yellow")
             "traffic light expected, given : 1st parameter is other value")

(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (cond [(and (not (light? a-value))
                  (not (light? another-value)))
             (error "traffic light expected, given : two other value")]
            [(not (light? a-value))
             (error "traffic light expected, given : 1st parameter is other value")]
            [else (error "traffic light expected, given : 2nd parameter is other value")])))