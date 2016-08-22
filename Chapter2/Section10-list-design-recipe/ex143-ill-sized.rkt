;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex143-ill-sized) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 143. Design ill-sized?. The function consumes a list of images loi and a positive number n. It produces the first image on loi that is not an n by n square; if it cannot find such an image, it produces #false.
(require 2htdp/image)


; ImageOrFalse is one of:
; - Image
; - #false


; List-of-images is one of:
; - '()
; - (cons Image List-of-images)


; Graphic constants
(define COLOR "red")
(define MODE "solid")


; Number -> Image
; use the n as the length of side to
; render a square
; examples:

(check-expect (square-sized 3) (square 3 MODE COLOR))
(check-expect (square-sized 10) (square 10 MODE COLOR))

(define (square-sized n)
  (square n MODE COLOR))


; Number -> Image
; use the w as width, the h
; as the height to render a
; rectangle.
; examples:

(check-expect (rect-sized 10 20)
              (rectangle 10 20 MODE COLOR))
(check-expect (rect-sized 12 30)
              (rectangle 12 30 MODE COLOR))

(define (rect-sized w h)
  (rectangle w h MODE COLOR))


; for construction the List-of-images
(define SQUARE-3 (square-sized 3))
(define SQUARE-4 (square-sized 4))
(define RECT-34 (rect-sized 3 4))


(define 3-FIRST (cons SQUARE-3
                      (cons SQUARE-4
                            (cons RECT-34 '()))))
(define 3-SECOND (cons SQUARE-4
                       (cons SQUARE-3
                             (cons RECT-34 '()))))
(define 3-ALL (cons SQUARE-3
                    (cons SQUARE-3
                          (cons SQUARE-3 '()))))


; List-of-images -> ImageOrFalse
; consume a List-of-images and determine
; weather a image which is not an n by n
; square belong to the list but in front of
; the n by n square.
; if true, return it; else return false.
; examples:

(check-expect (ill-sized 3-FIRST 3) SQUARE-4)
(check-expect (ill-sized 3-SECOND 3) SQUARE-4)
(check-expect (ill-sized 3-FIRST 10) SQUARE-3)
(check-expect (ill-sized 3-SECOND 4) SQUARE-3)
(check-expect (ill-sized 3-ALL 3) #false)
(check-expect (ill-sized '() 10) #false)
(check-error (ill-sized 10 10))

(define (ill-sized loi n)
  (cond [(empty? loi) #false]
        [(cons? loi)
         (if (equal? (first loi)
                          (square-sized n))
             (ill-sized (rest loi) n)
             (first loi))]
        [else (error "TypeError: the input should be a List-of-images")]))
