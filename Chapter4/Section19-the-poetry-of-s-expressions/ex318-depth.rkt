;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex318-depth) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; S-expr -> N

(check-expect (depth 123 ) 1)
(check-expect (depth "hello") 1)
(check-expect (depth 'world ) 1)
(check-expect (depth '(world hello)) 3)
(check-expect (depth '(((world) hello) hello)) 4)

(define (depth sexp)
  (local (; S-expr -> N
          ; determine the depth of the given sexpr
          (define (depth-sexp s)
            (cond [(atom? sexp) 1]
                  [else (depth-sl s)]))
          ; SL -> N
          ; find the maxium depth of sl and add1, then reutrn it.
          (define (depth-sl sl)
            (cond [(empty? sl) 1]
                  [else (add1 (max (depth (first sl)) ; find the maxium depth of sl.
                                   (depth-sl (rest sl))))])))
    (depth-sexp sexp)))


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

