;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex387-cross) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] [List-of Number] -> [List-of Number]
; replace the final '() in front with end

(check-expect (replace-eol-with (cons 1 '()) '(2))
              (cons 1 '(2)))
(check-expect (replace-eol-with '() '(1 2)) '(1 2))
(check-expect (replace-eol-with '(1 2 3) '(6 8)) '(1 2 3 6 8))

(define (replace-eol-with front end)
  (cond [(empty? front) end]
        [else (cons (first front)
                    (replace-eol-with (rest front) end))]))


; [List-of Symbol] [List-of Number] -> [List-of [List Symbol Number]]
; produces all possible pairs of symbols and numbers.

(check-expect (cross '(a b c) '(1 2)) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))
(check-expect (cross '(a b) '(2 1)) '((a 2) (a 1) (b 2) (b 1)))

(define (cross los lon)
  (cond [(empty? los) '()]
        [else (append (map (lambda (num) `(,(first los) ,num))
                           lon)
                      (cross (rest los) lon))]))