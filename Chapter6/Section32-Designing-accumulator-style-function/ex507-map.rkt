;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex507-map) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [ [List-of Any] -> [List-of Any] ] [List-of Any] -> [List-of Any]
; produces a list with all items turn to (f item).

(check-expect (map-another add1 '(1 2 10 -1))
              '(2 3 11 0))
(check-expect (map-another (lambda (n) (implode (make-list n "a")))
                           '(3 2 1))
              '("aaa" "aa" "a"))

(define (map-another f l0)
  (local (; [List-of Any] [List-of Any]
          ; -> [List-of Any]
          (define (map/a l r)
            (cond [(empty? l) (reverse r)]
                  [else (map/a (rest l)
                               (cons (f (first l))
                                     r))]))
          )
    (map/a l0 '())))