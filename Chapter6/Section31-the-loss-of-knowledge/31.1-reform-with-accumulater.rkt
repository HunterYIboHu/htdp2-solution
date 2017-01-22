;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 31.1-reform-with-accumulater) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> [List-of Number]
; convert a list of relative to absolute distances
; the first number represents the distance to the origin
 
(check-expect (relative->absolute.v2 '(50 40 70 30 30))
              '(50 90 160 190 220))
(check-expect (relative->absolute.v2 '())
              '())
 
(define (relative->absolute.v2 l0)
  (local (
    ; [List-of Number] Number -> [List-of Number]
    (define (relative->absolute/a l accu-dist)
      (cond
        [(empty? l) '()]
        [else
          (local ((define accu (+ (first l) accu-dist)))
            (cons accu
                 (relative->absolute/a (rest l) accu)))])))
    (relative->absolute/a l0 0)))


;; test
;;(relative->absolute/a (list 3 2 7))
;;== (relative->absolute/a (list 3 2 7) 0)
;;== (cons 3 (relative->absolute/a (list 2 7) 3))
;;== (cons 3 (cons 5 (relative->absolute/a (list 7) 5)))
;;== (cons 3 (cons 5 (cons 12 (relative->absolute/a '() 12))))
;;== (cons 3 (cons 5 (cons 12 '())))