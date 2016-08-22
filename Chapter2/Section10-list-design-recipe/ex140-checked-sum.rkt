;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex140-checked-sum) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-amounts is one of:
; - '()
; - (cons PositiveNumber List-of-amounts)
; interpretation a List-of-amounts represents some amounts of money
; examples:

(define origin '())
(define sec (cons 1 '()))
(define thd (cons 2 (cons 1 '())))


; A List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)
; examples:

(define pos-num (cons 5 '()))
(define neg-num (cons -1 '()))
(define long-pos (cons 123123
                       (cons 34234
                             (cons 23
                                   (cons 1
                                         (cons 12
                                               (cons 99 '())))))))


; List-of-numbers -> Boolean
; determine weather l is an element of List-of-amounts
; examples:

(check-expect (pos? pos-num) #true)
(check-expect (pos? neg-num) #false)


(define (pos? l)
  (cond [(empty? l) #true]
        [(cons? l)
         (if (and (>= (first l) 0)
                  (pos? (rest l)))
             #true
             #false)]))


; use stepper to trace the function pos?
(pos? long-pos)


; List-of-amouts -> Number
; determine the sum of Numbers on l, is l is empty, the result is 0.
; examples:

(check-expect (sum origin) 0)
(check-expect (sum sec) 1)
(check-expect (sum thd) 3)
(check-error (sum 20))

(define (sum l)
  (cond [(empty? l) 0]
        [(cons? l)
         (+ (first l) (sum (rest l)))]
        [else (error "TypeError: l should be a list.")]))


; List-of-numbers -> Number
; check weather l belongs to List-of-amounts,
; if true, then sum the numbers in l;
; else signals an error.
; examples:

(check-error (checked-sum neg-num))
(check-expect (checked-sum long-pos) 157492)
(check-expect (checked-sum pos-num) 5)
(check-expect (checked-sum '()) 0)

(define (checked-sum l)
  (if (pos? l)
      (cond [(empty? l) 0]
            [(cons? l)
             (+ (first l) (sum (rest l)))])
      (error "TypeError: the input is not List-of-amounts")))


; Question:
; What does sum compute for an element of List-of-numbers?

; Answer:
; if all the numbers on the List-of-numbers is positive number, treat it
; same as List-of-amounts; else raise an error.