;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex503-palindrome) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [NEList-of Any] -> [NEList-of Any]
; produces the palindrome by mirroring the list around the last item.

(check-expect (palindrome (explode "abc"))
              (explode "abcba"))
(check-expect (palindrome '(1 2 3))
              '(1 2 3 2 1))

(define (palindrome l0)
  (local (; [NEList-of Any] [NEList-of Any] -> [NEList-of Any]
          ; produces the mirror of l.
          ; accumulator head is a list collects the items which
          ; is removed from l0 on l.          
          ; accumulator tail is a list collects the reverse of
          ; items from first to the front item of l in l0.
          (define (palindrome/a l head tail)
            (cond [(empty? (rest l)) (append head l tail)]
                  [else (palindrome/a (rest l)
                                      `(,@head ,(first l))
                                      (cons (first l) tail))]))
          )
    (palindrome/a l0 '() '())))