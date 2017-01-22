;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex450-find-root-inc) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define ε 0.0001)


;; functions
; [Number -> Number] Number Number -> Number
; determine R such that f has a root in [R, (+ R ε)]
; assume f is continuous
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; (3) f is monotonically increasing
; generative divide interval in half, the root is in
; one of the two halves, pick according to (2)

(check-satisfied (find-root inc -10 1) (check-root inc))
(check-satisfied (find-root inc -100 10) (check-root inc))
(check-satisfied (find-root inc-2 -100 10) (check-root inc-2))
(check-satisfied (find-root inc-2 -200 100) (check-root inc-2))

(define (find-root f left right)
  (find-root/inc f left right (f left) (f right)))


; [Number -> Number] Number Number Number Number-> Number
; determine R such that f has a root in [R, (+ R ε)]
; assume f is continuous
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; (3) f is monotonically increasing
; generative divide interval in half, the root is in
; one of the two halves, pick according to (2)
; add the two boundary value of the interval.

(define (find-root/inc f left right f@left f@right)
  (cond [(<= (- right left) ε) left]
        [else (local ((define mid (/ (+ left right) 2))
                      (define f@mid (f mid)))
                (if (> f@mid 0)
                    (find-root/inc f left mid f@left f@mid)
                    (find-root/inc f mid right f@mid f@right)))]))


;; check function
; Number -> Number
; this is an monotonically increasing function.

(check-expect (inc -0.5) 0)
(check-expect (inc 10) 21)
(check-expect (inc -100) -199)

(define (inc x)
  (add1 (* 2 x)))


; Number -> Number
; this is another monotonically increasing function.

(check-expect (inc-2 10) 999)
(check-expect (inc-2 1) 0)
(check-expect (inc-2 -2) -9)

(define (inc-2 x)
  (sub1 (* x x x)))


; [Number -> Number] -> [Number -> Boolean]
; produces a function which determine the given value
; is near the root of f.

(define (check-root f)
  (local ((define PRECSION 0.05)
          ; Number Number -> Boolean
          ; determine whether (abs num) sub 0 is less than acc.
          (define (in-range num acc)
            (>= acc (- (abs num) 0))))
    (lambda (value) (in-range (f value) PRECSION))))