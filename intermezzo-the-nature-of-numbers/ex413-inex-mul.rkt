;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex413-inex-mul) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data definitions
(define-struct inex [mantissa sign exponent])
; An Inex is a structure:
;    (make-inex N99 S N99)
; An S is one of:
; - 1
; - -1
; An N99 is an N between 0 and 99 (inclusive).


;; functions
; N Number N -> Inex
; make an instance of Inex after checking the arguments

(check-expect (create-inex 10 -1 2) (make-inex 10 -1 2))
(check-expect (create-inex 10 1 2) (make-inex 10 1 2))
(check-error (create-inex 10 -2 2))
(check-error (create-inex 100 -1 2))
(check-error (create-inex 20 -1 100))

(define (create-inex m s e)
  (cond [(and (<= 0 m 99) (<= 0 e 99)
              (or (= s 1) (= s -1)))
         (make-inex m s e)]
        [else (error "bad values given")]))


;; constants
(define MAX-POSITIVE (create-inex 99 1 99))
(define MIN-POSITIVE (create-inex 1 -1 99))


; Inex -> Number
; convert an inex into its numberic equivalent

(check-expect (inex->number (create-inex 10 1 2))
              1000)
(check-expect (inex->number (create-inex 9 -1 1))
              0.9)

(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt 10 (* (inex-sign an-inex)
                 (inex-exponent an-inex)))))


; Inex Inex -> Inex
; multiply the two i and produces the result.

(check-expect (inex* (create-inex 1 1 1)
                     (create-inex 1 1 1))
              (create-inex 1 1 2))
(check-expect (inex* (create-inex 10 1 2)
                     (create-inex 5 1 2))
              (create-inex 50 1 4))
(check-expect (inex* (create-inex 10 1 2)
                     (create-inex 10 -1 3))
              (create-inex 10 -1 0))
(check-expect (inex* (create-inex 10 1 2)
                     (create-inex 10 -1 2))
              (create-inex 10 1 1))
(check-expect (inex* (create-inex 99 1 1)
                     (create-inex 99 1 1))
              (create-inex 98 1 4))

(check-error (inex* (create-inex 99 1 1)
                    (create-inex 99 1 98)))
(check-error (inex* (create-inex -1 1 1)
                    (create-inex 1 1 1)))

(define (inex* i-1 i-2)
  (local ((define new-mantissa (* (inex-mantissa i-1)
                                  (inex-mantissa i-2)))
          (define new-exponent
            (+ (* (inex-sign i-1) (inex-exponent i-1))
               (* (inex-sign i-2) (inex-exponent i-2))))
          ; Number -> Number
          ; produces the given n if it satisfied the condition.
          (define (check-exponent e)
            (local ((define real-e (abs e)))
              (if (> 100 real-e)
                  real-e
                  (error "The new exponent is too large.")))))
    (cond [(< new-mantissa 100)
           (create-inex new-mantissa
                        (if (positive? new-exponent) 1 -1)
                        (check-exponent new-exponent))]
          [(<= 100 new-mantissa 999)
           (create-inex (round (/ new-mantissa 10))
                        (if (positive? (add1 new-exponent)) 1 -1)
                        (check-exponent (add1 new-exponent)))]
          [(<= new-mantissa 9801)
           (create-inex (round (/ new-mantissa 100))
                        (if (positive? (+ new-exponent 2)) 1 -1)
                        (check-exponent (+ new-exponent 2)))]
          [else (error "The new mantissa is out of range.")])))












