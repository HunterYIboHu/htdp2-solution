;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex412-inex+) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; adds two Inex representations of numbers that have same exponent.
; adds 1 exponent by rounding the number.

(check-expect (inex+ (create-inex 4 1 2)
                     (create-inex 5 1 2))
              (create-inex 9 1 2))
(check-expect (inex+ (create-inex 6 1 10)
                     (create-inex 1 1 10))
              (create-inex 7 1 10))

(check-expect (inex+ (create-inex 55 1 10)
                     (create-inex 55 1 10))
              (create-inex 11 1 11))
(check-expect (inex+ (create-inex 56 1 10)
                     (create-inex 56 1 10))
              (create-inex 11 1 11))
(check-expect (inex+ (create-inex 58 1 10)
                     (create-inex 58 1 10))
              (create-inex 12 1 11))

(check-expect (inex+ (create-inex 1 1 0)
                     (create-inex 1 -1 1))
              (create-inex 11 -1 1))
(check-expect (inex+ (create-inex 1 -1 1)
                     (create-inex 1 1 0))
              (create-inex 11 -1 1))

(check-error (inex+ (create-inex 6 1 8)
                    (create-inex 2 1 10)))
(check-error (inex+ (create-inex 99 1 99)
                    (create-inex 99 1 99)))

(define (inex+ i-1 i-2)
  (local ((define inexs (map (lambda (i) (* (inex-sign i)
                                            (inex-exponent i)))
                             `(,i-1 ,i-2)))
          (define exponent-1 (first inexs))
          (define exponent-2 (second inexs)))
    (cond [(= exponent-1 exponent-2)
           (local ((define new-mantissa (+ (inex-mantissa i-1)
                                           (inex-mantissa i-2))))
             (cond [(< new-mantissa 100)
                    (create-inex new-mantissa
                                 (inex-sign i-1)
                                 (inex-exponent i-1))]
                   [(<= 100 new-mantissa 198)
                    (local ((define new-exponent (add1 (inex-exponent i-1))))
                      (if (< new-exponent 100)
                          (create-inex (round (/ new-mantissa 10))
                                       (inex-sign i-1)
                                       new-exponent)
                          (error "Exponent is over 100.")))]))]
          [(= 1 (abs (- exponent-1 exponent-2)))
           (local ((define judge-exp (< exponent-1 exponent-2))
                   (define new-mantissa (if judge-exp
                                            (+ (inex-mantissa i-1)
                                               (* 10 (inex-mantissa i-2)))
                                            (+ (inex-mantissa i-2)
                                               (* 10 (inex-mantissa i-1))))))
             (cond [(and (< new-mantissa 100)
                         judge-exp)
                    (create-inex new-mantissa
                                 (inex-sign i-1)
                                 (inex-exponent i-1))]
                   [(and (< new-mantissa 100)
                         (not judge-exp))
                    (create-inex new-mantissa
                                 (inex-sign i-2)
                                 (inex-exponent i-2))]
                   [judge-exp (local ((define new-exponent (add1 (inex-exponent i-1))))
                                (if (< new-exponent 100)
                                    (create-inex (round (/ new-mantissa 10))
                                                 (inex-sign i-1)
                                                 new-exponent)
                                    (error "Exponent is over 100.")))]
                   ;; some error happens here.
                   [else (local ((define new-exponent (add1 (inex-exponent i-2))))
                           (if (< new-exponent 100)
                               (create-inex (round (/ new-mantissa 10))
                                            (inex-sign i-2)
                                            new-exponent)
                               (error "Exponent is over 100.")))]))]
          [else (error "Exponents are not same.")])))





