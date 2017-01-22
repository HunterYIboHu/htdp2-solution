;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex501-how-many) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; [List-of Any] -> N
; produces the number of items on l.
; it signals an error when the input is not list.

(check-expect (how-many '(1 's '())) 3)
(check-expect (how-many '()) 0)
(check-error (how-many 1))

(define (how-many l0)
  (local (; [List-of Any] N -> N
          ; produce the number of items on l
          ; accumulator len represent the number of items meet since the
          ; first one.
          (define (how-many/a l len)
            (cond [(empty? l) len]
                  [else (how-many/a (rest l)
                                    (add1 len))]))
          )
    (if (list? l0)
        (how-many/a l0 0)
        (error "l0 should be a list!"))))


;; Questions
;; Q1: Does the accumulator reduce the amount of space needed to
;; compute the result?
;; A1: Yes, for it just need O(1) space used by len.