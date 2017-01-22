;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex492-the-use-of-accumulator) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] -> [List-of Number]
; convert a list of relative to absolute distances
; the first number represents the distance to the origin
 
(check-expect (relative->absolute '(50 40 70 30 30))
              '(50 90 160 190 220))

(define (relative->absolute l)
 (reverse
   (foldr (lambda (f l) (cons (+ f (first l)) l))
          (list (first l))
          (reverse (rest l)))))


;; Questions
;; Q1: Does your friend’s solution mean there is no need for our
;; complicated design in this motivational section?
;; A1: No, this solution is not easy to understand, because there is
;; no tips about why we use lambda; further more, the use of abstraction
;; make it hard to translate it into another language.
;; And there need more purpose statement.


; [List-of Any] -> [List-of Any]
; design my own reverse.

(check-expect (reverse/me '() ) '())
(check-satisfied (reverse/me '(1 2 3 4))
                 (lambda (l) (equal? l (reverse '(1 2 3 4)))))

(define (reverse/me l)
  (local (; [List-of Any] [List-of Any] -> [List-of Any]
          (define (reverse/a origin result)
            (cond [(empty? origin) result]
                  [else (reverse/a (rest origin)
                                   (cons (first origin) result))])))
    (reverse/a l '())))