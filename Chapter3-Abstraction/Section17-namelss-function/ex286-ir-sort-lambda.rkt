;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex286-ir-sort-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; structs
(define-struct IR [name description acq-price sale-price])
; an inventory record is (make-IR String String Number Number)
; (make-IR n d ap sp) the n means the name of IR, and the d is the description
; and the ap, sp are acquisition price and sale price.

(define IR-1 (make-IR "delicious apple"
                      "An special kind of apple which come from Malizia"
                      1000
                      1500))
(define IR-2 (make-IR "banana"
                      "Just a banana, a little yellow."
                      996
                      1205))
(define IR-3 (make-IR "Salt"
                      "Come from Hainan, salty."
                      540
                      999))


; functions
; [List-of IR] -> [List-of IR]
; sort the given l by the difference between the two prices.
; the larger one first.

(check-expect (sort-ir `(,IR-1 ,IR-2 ,IR-3)) `(,IR-1 ,IR-3 ,IR-2))
(check-expect (sort-ir `(,IR-2 ,IR-3 ,IR-1)) `(,IR-1 ,IR-3 ,IR-2))

(define (sort-ir l)
  (local (; IR -> Number
          ; get the difference between the given IR's two prices.
          (define (get-diff ir)
            (- (IR-sale-price ir)
               (IR-acq-price ir))))
    (sort l (lambda (x y) (> (get-diff x) (get-diff y))))))