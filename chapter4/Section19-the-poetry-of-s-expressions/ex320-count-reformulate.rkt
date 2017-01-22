;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex320-count-reformulate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An S-expr is one of:
; - String
; - Number
; - Symbol
; - [List-of S-expr]


; An SL is one of: 
; – '()
; – (cons S-expr SL)


;; functions
; S-expr Symbol -> N
; counts all occurences of sy in sexp

(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(o (o p)) 'o) 2)
(check-expect (count '("1" 2 'o) 'p) 0)

(define (count s-expr sy)
  (cond [(cons? s-expr)
         (local (; SL Symbol -> N
                 ; counts all occurences of sy in the sl
                 (define (count/sl sl)
                   (cond [(empty? sl) 0]
                         [else (+ (count (first sl) sy)
                                  (count/sl (rest sl)))])))
           (count/sl s-expr))]
        [(number? s-expr) 0]
        [(string? s-expr) 0]
        [(symbol? s-expr) (if (symbol=? s-expr sy) 1 0)]))


;; data difinition-v2
; An S-expr is one of:
; - String
; - Number
; - Symbol
; - [List-of S-expr]


; S-expr Symbol -> N
; counts all occurences of sy in sexp

(check-expect (count-v2 'world 'hello) 0)
(check-expect (count-v2 '(world hello) 'hello) 1)
(check-expect (count-v2 '(o (o p)) 'o) 2)
(check-expect (count-v2 '("1" 2 'o) 'p) 0)

(define (count-v2 s-expr sy)
  (cond [(cons? s-expr)
         (foldr + 0 (map (lambda (expr) (count-v2 expr sy)) s-expr))]
        [(symbol? s-expr) (if (symbol=? s-expr sy) 1 0)]
        [else 0]))


