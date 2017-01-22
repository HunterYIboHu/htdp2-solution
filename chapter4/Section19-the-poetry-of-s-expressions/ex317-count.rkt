;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex317-count) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; An Atom is one of: 
; – Number
; – String
; – Symbol


; An S-expr is one of: 
; – Atom
; – SL


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

(define (count sexp sy)
  (cond [(atom? sexp) (local ((define (count-atom at)
                                (cond [(number? at) 0]
                                      [(string? at) 0]
                                      [(symbol? at) (if (symbol=? at sy) 1 0)])))
                        (count-atom sexp))]
        [else (local ((define (count-sl sl)
                        (cond [(empty? sl) 0]
                              [else (+ (count (first sl) sy)
                                       (count-sl (rest sl)))])))
                (count-sl sexp))]))


;; auxiliary functions
; X -> Boolean
; determine whether the given x is an Atom.

(check-expect (atom? 100) #true)
(check-expect (atom? "hello") #true)
(check-expect (atom? 'a) #true)
(check-expect (atom? #false) #false)

(define (atom? x)
  (or (number? x)
      (string? x)
      (symbol? x)))

