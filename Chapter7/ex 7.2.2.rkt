;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |ex 7.2.2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-steuct car (cate pass size weight length color))

;; car is (make-car Category Natural Size Weight Length Color)
;; a car with the number of passengers, its size(can be false), its weight(can be false), its length(can be false) and its colour(can be false)

;; Category is one of:
;; - "Bus"
;; - "Limo"
;; - "Car"
;; - "Subway"

;; Size is one of:
;; - Natural
;; - false

;; Weight is one of:
;; - Natural
;; - false

;; Length is one of:
;; - Natural
;; - false

;; Color is one of:
;; - String
;; - false

(define B1 (make-car "Bus"    30  6     false false false))
(define L1 (make-car "Limo"   5   false false false "gold"))
(define C1 (make-car "Car"    5   false 2     false false))
(define S1 (make-car "Subway" 100 false false 50    false))

#;
(define (fn-for-car c)
  (cond [(string=? (car-cate c) "Bus") (... (car-pass c)
                                            (car-size c))]
        [(string=? (car-cate c) "Limo") (... (car-pass c)
                                             (car-color c))]
        [(string=? (car-cate c) "Car" (... (car-pass c)
                                           (car-weight c)))]
        [else
         (... (car-pass c)
              (car-length c))]))