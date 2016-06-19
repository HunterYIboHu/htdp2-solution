;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex106-car-define) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct vehicle [passenger lcs-plt fuel-con])
; Vehicle is (make-vehicle psgr lcs fuel)
; interpretation the psgr means the number of passenger
; the lcs means the license plate
; the fuel means fuel consumption (miles per gallon)
; examples:

(define automobile
  (make-vehicle 4 "B5230" 20))
(define van
  (make-vehicle 8 "EA403" 15))
(define bus
  (make-vehicle 30 "J2007" 10))
(define SUV
  (make-vehicle 6 "EA304" 15))
(define truck
  (make-vehicle 2 "EJ3320" 12))


; Number -> Vehicle or Boolean
; determine which vehicle shoule be choosen by the
; number of passenger.
; examples:
(check-expect (decide-car 20) bus)
(check-expect (decide-car 2) truck)
(check-expect (decide-car 8) van)
(check-expect (decide-car 5) SUV)
(check-expect (decide-car 3) automobile)
(check-expect (decide-car 100) #false)

(define (decide-car par-num)
  (cond [(<= par-num 2) truck]
        [(<= par-num 4) automobile]
        [(<= par-num 6) SUV]
        [(<= par-num 8) van]
        [(<= par-num 30) bus]
        [else #false]))
