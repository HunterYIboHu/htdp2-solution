;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex490-reformulate-add-to-each) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> [List-of Number]
; convert a list of relative to absolute distances
; the first number represents the distance to the origin
 
(check-expect (relative->absolute '(50 40 70 30 30))
              '(50 90 160 190 220))
(check-expect (relative->absolute '())
              '())

(define (relative->absolute lon)
  (cond [(empty? lon) '()]
        [else (local ((define rest-of-l
                        (relative->absolute (rest lon)))
                      (define adjusted
                              (add-to-each (first lon) rest-of-l)))
                (cons (first lon) adjusted))]))


;; auxiliary functions
; Number [List-of Number] -> [List-of Number]
; add n to each number on l
 
(check-expect (cons 50 (add-to-each 50 '(40 110 140 170)))
              '(50 90 160 190 220))
(check-expect (cons 50 (add-to-each 50 '()))
              '(50))

(define (add-to-each num lon)
  (map (λ (n) (+ num n)) lon))