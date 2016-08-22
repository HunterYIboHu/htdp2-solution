;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex141-boolean-functions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; List-of-booleans is one of:
; - '()
; - (cons Boolean List-of-booleans)
; interpretation a List-of-booleans represents some boolean collection.
; examples:

(define ONE-TRUE (cons #t (cons #f (cons #f '()))))
(define TWO-TRUE (cons #t (cons #f (cons #t '()))))
(define ALL-TRUE (cons #t (cons #t (cons #t '()))))
(define ALL-FALSE (cons #f (cons #f (cons #f '()))))


; List-of-booleans -> Boolean
; determine weather all the booleans on l is #true
; examples:

(check-error (all-true (cons 1 '())))
(check-error (all-true 1))
(check-expect (all-true ONE-TRUE) #false)
(check-expect (all-true TWO-TRUE) #false)
(check-expect (all-true ALL-TRUE) #true)

(define (all-true l)
  (cond [(empty? l) #true]
        [(cons? l)
         (and (boolean=? (first l) #true)
              (all-true (rest l)))]
        [else (error "all-true: expects a boolean as 1st argument.")]))


; List-of-booleans -> Boolean
; determine weather at least one item on the l is #true
; examples:

(check-error (one-true (cons 1 '())))
(check-error (one-true 1))
(check-expect (one-true ONE-TRUE) #true)
(check-expect (one-true ALL-TRUE) #true)
(check-expect (one-true ALL-FALSE) #false)

(define (one-true l)
  (cond [(empty? l) #false]
        [(cons? l)
         (or (boolean=? (first l) #true)
             (one-true (rest l)))]
        [else (error "one-true: expects a boolean as 1st argument.")]))
