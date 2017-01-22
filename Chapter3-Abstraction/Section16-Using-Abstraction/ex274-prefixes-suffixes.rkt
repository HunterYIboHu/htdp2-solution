;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex274-prefixes-suffixes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of 1String] -> [List-of [List-of 1String]]
; produces the list of all prefixes, a list p is a prefix of l
; if p and l are the same up through all items in p.

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "A")) (list (list "A")))
(check-expect (prefixes (list "A" "B"))
              (list (list "A") (list "A" "B")))
(check-expect (prefixes (list "A" "B" "C"))
              (list (list "A") (list "A" "B") (list "A" "B" "C")))

(define (prefixes los)
  (cond [(empty? los) '()]
        [else (local ((define first-elt (first los))
                      ; 1String [List-of [List-of 1String]] ->
                      ; [List-of [List-of 1String]]
                      ; add the given s to the head of all the lol's list
                      (define (add-first-at-head lls)
                        (cons first-elt lls)))
                (cons `(,first-elt)
                      (map add-first-at-head (prefixes (rest los)))))]))


; [List-of 1String] -> [List-of [List-of 1String]]
; produces the list of all suffix of l.A list s is a suffix of l if
; p and l are the same from the end, up through all items in s.

(check-expect (suffixes '()) '())
(check-expect (suffixes (list "A")) (list (list "A")))
(check-expect (suffixes (list "A" "B")) (list (list "A" "B") (list "B")))
(check-expect (suffixes (list "A" "B" "C"))
              (list (list "A" "B" "C") (list "B" "C") (list "C")))

(define (suffixes los)
  (cond [(empty? los) '()]
        [else (cons los
                    (suffixes (rest los)))]))