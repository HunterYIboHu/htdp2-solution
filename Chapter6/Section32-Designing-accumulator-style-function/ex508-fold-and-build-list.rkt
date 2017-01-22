;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex508-fold-and-build-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X Y] [X Y -> Y] Y [List-of X] -> Y
; produces a value is fold by all items of l0.

(check-expect (f*ldl + 0 '(1 2 3))
              (foldl + 0 '(1 2 3)))
(check-expect (f*ldl cons '() '(a b c))
              (foldl cons '() '(a b c)))

(define (f*ldl f e l0)
  (local (; [X Y] Y [List-of X] -> Y
          ; produces a value is fold by all items of l.
          ; accumulator a represents the current value that use the
          ; difference between l0 and l as arguments.
          (define (fold/a a l)
            (cond
              [(empty? l) a]
              [else
               (fold/a (f (first l) a) (rest l))])))
    (fold/a e l0)))


; [Y] N [N -> Y] -> [List-of Y]
; produces a list of value compute by f and arguments from 0 to (sub1 n)

(check-expect (build-l*st 10 add1)
              (build-list 10 add1))
(check-expect (build-l*st 0 add1)
              '())

(define (build-l*st n0 f)
  (local (; [Y] N [N -> Y] [List-of Y] -> [List-of Y]
          ; produces a list of value compute by f and arguments
          ; from 0 to (sub1 n).
          ; accumulator r represent the result consist of f apply from
          ; n0 to the current n.
          (define (build-l*st/a n r)
            (cond [(= 0 n) r]
                  [else (build-l*st/a (sub1 n) (cons (f (sub1 n)) r))]))
          )
    (build-l*st/a n0 '())))


;; Questions
;; Q1: Assume that the difference between l0 and l is (list x1 x2 x3).
;; What is a then?
;; A1: a is (f x3 (f x2 (f x1 e))).