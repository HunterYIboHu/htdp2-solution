;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex32.2-invert-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of X] -> [List-of X]
; construct the reverse of alox

(check-expect (invert.v2 '(a b c)) '(c b a))

(define (invert.v2 alox0)
  (local (; [List-of X] [List-of X] -> [List-of X]
          ; construct the reverse of alox
          ; accumulator a is the list of all
          ; those items on alox0 that precede alox
          ; in reverse order.
          (define (invert/a alox a)
            (cond [(empty? alox) a]
                  [else (invert/a (rest alox)
                                  (cons (first alox) a))])))
    (invert/a alox0 '())))