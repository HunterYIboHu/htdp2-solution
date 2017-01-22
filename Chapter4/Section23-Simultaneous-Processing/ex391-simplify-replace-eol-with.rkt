;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex391-simplify-replace-eol-with) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of Number] [List-of Number] -> [List-of Number]
; replace the final '() in front with end.

(check-expect (replace-eol-with '() '(1 2 3)) '(1 2 3))
(check-expect (replace-eol-with '() '()) '())
(check-expect (replace-eol-with '(1 2 3) '(1 2 3)) '(1 2 3 1 2 3))
(check-expect (replace-eol-with '(1 2 3) '()) '(1 2 3))

(define (replace-eol-with front end)
  (cond [(empty? front) end]
        [else (cons (first front)
                    (replace-eol-with (rest front) end))]))