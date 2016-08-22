;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex190-prefixes-suffixes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; List-of-1String is one of:
; - '()
; - (cons 1String List-of-1String)


;; main functions
; List-of-1String -> List-of-List-of-1String
; produces the list of all prefixes, a list p is a prefix of l
; if p and l are the same up through all items in p.

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "A")) (list (list "A")))
(check-expect (prefixes (list "A" "B"))
              (list (list "A") (list "A" "B")))
(check-expect (prefixes (list "A" "B" "C"))
              (list (list "A") (list "A" "B") (list "A" "B" "C")))

(define (prefixes l)
  (cond [(empty? l) '()]
        [else (cons (list (first l))
                    (add-at-head (first l) (prefixes (rest l))))]))


; List-of-1String -> List-of-List-of-1String
; produces the list of all suffix of l.A list s is a suffix of l if
; p and l are the same from the end, up through all items in s.

(check-expect (suffixes '()) '())
(check-expect (suffixes (list "A")) (list (list "A")))
(check-expect (suffixes (list "A" "B")) (list (list "A" "B") (list "B")))
(check-expect (suffixes (list "A" "B" "C"))
              (list (list "A" "B" "C") (list "B" "C") (list "C")))

(define (suffixes l)
  (cond [(empty? l) '()]
        [else (cons l (suffixes (rest l)))]))


;; auxiliary functions
; 1String List-of-List-of-1String-> List-of-List-of-1String
; produce the combine of the given s with all prefixes of los

(check-expect (add-at-head "A" '()) '())
(check-expect (add-at-head "A" (list (list "B"))) (list (list "A" "B")))
(check-expect (add-at-head "A" (list (list "B") (list "B" "C")))
              (list (list "A" "B") (list "A" "B" "C")))

(define (add-at-head s ll)
  (cond [(empty? ll) '()]
        [else (cons (cons s (first ll))
                    (add-at-head s (rest ll)))]))





