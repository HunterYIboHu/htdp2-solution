;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex260-filter-three-func) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define lon-1 '("Nano" "Stack" "Matheew" "Jusus"))
(define lon-2 '("Nano" "Stack" "Key" "Jay"))
(define lon-3 '("Stack" "Jusus" "Babo"))


;; structs
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

(define loir-1 `(,IR-1 ,IR-2 ,IR-3))


; Number [List-of IR] -> [List-of IR]
; produce a list of IR whose sales price is below ua.

(check-expect (eliminate-expensive 1000 loir-1) `(,IR-3))
(check-expect (eliminate-expensive 1210 loir-1) `(,IR-2 ,IR-3))

(define (eliminate-expensive ua l)
  (local (; IR
          ; determine whether the IR's sale price is below ua.
          (define (eliminate-ua ir)
            (< (IR-sale-price ir) ua)))
    (filter eliminate-ua l)))


; String [List-of IR] -> [List-of IR]
; produce a list of IR do not contain the IR whose name is ty.

(check-expect (recall "delicious apple" loir-1) `(,IR-2 ,IR-3))
(check-expect (recall "Nothing" loir-1) loir-1)
(check-expect (recall "Salt" loir-1) `(,IR-1 ,IR-2))

(define (recall ty l)
  (local (; String IR -> Boolean
          ; return #false is the IR's name is same as given String
          (define (bad? ir)
            (not (string=? ty (IR-name ir)))))
    (filter bad? l)))


; [List-of String] [List-of String] -> [List-of String]
; produce a list of name which occur in both of the given lists.

(check-expect (selection lon-1 lon-2) '("Nano" "Stack"))
(check-expect (selection lon-1 lon-3) '("Stack" "Jusus"))
(check-expect (selection lon-2 lon-3) '("Stack"))

(define (selection l-1 l-2)
  (local (; String -> Boolean
          ; determine whether the given item is occur in the both lists.
          (define (occur-in-two-list? name)
            (and (member? name l-1)
                 (member? name l-2)))
          )
    (filter occur-in-two-list? l-1)))




















