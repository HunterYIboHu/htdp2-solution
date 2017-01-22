;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex290-fold-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; constatns
(define DOT (circle 3 "solid" "red"))
(define SQUARE (square 5 "outline" "black"))


; [X] [List-of X] [List-of X] -> [List-of X]
; append the given two list into one, the latter list on the right.

(check-expect (append-from-fold '(1 2) '(3 4)) '(1 2 3 4))
(check-expect (append-from-fold '("A" "bc") '("sss")) '("A" "bc" "sss"))

(define (append-from-fold former latter)
  (foldr (lambda (x l) (reverse (cons x (reverse l))))
         former (reverse latter)))


; [X] [List-of X] [List-of X] -> [List-of X]
; append the given two list into one, the latter list on the right.

(check-expect (append-from-foldl '(1 2) '(3 4)) '(1 2 3 4))
(check-expect (append-from-foldl '("A" "bc") '("sss")) '("A" "bc" "sss"))

(define (append-from-foldl former latter)
  (foldl (lambda (x l) (reverse (cons x (reverse l))))
         former latter))


; [List-of Number] -> Number
; computes the sum of the given list of number.

(check-expect (sum '(1 2 3 4 5)) 15)
(check-expect (sum '(0.2 0.5 -0.3 100)) 100.4)

(define (sum l)
  (foldr + 0 l))


; [List-of Number] -> Number
; computes the product of the given list of number

(check-expect (product '(1 2 3 4 5)) 120)
(check-expect (product '(10 20 40 0)) 0)

(define (product l)
  (foldr * 1 l))


; [List-of Image] -> Image
; horizontally composes a list of Images.

(check-expect (compose-img/hor (make-list 3 DOT)) (beside DOT DOT DOT))
(check-expect (compose-img/hor `(,DOT ,SQUARE)) (beside DOT SQUARE))

(define (compose-img/hor l)
  (foldr beside empty-image l))


; [List-of Image] -> Image
; stack a list of images veritically.

(check-expect (compose-img/ver (make-list 3 DOT)) (above DOT DOT DOT))
(check-expect (compose-img/ver `(,DOT ,SQUARE ,SQUARE))
              (above DOT SQUARE SQUARE))

(define (compose-img/ver l)
  (foldr above empty-image l))