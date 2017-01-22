;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |111|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; definitions
; A Lam is one of:
; - a Symbol
; - (list 'λ (list Symbol) Lam)
; - (list Lam Lam)


;; data examples
(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ (x) (x x)) (λ (x) (x x))))
(define ex5 '((λ (x) x) (λ (x) x)))
(define ex6 '(((λ (y) (λ (x) y)) (λ (z) z)) (λ (w) w)))
(define ex7 'x)
(define ex8 'y)
(define ex9 '(x x))


;; functions
; Lam -> Boolean
; determines whether the given ex is a variable.

(check-expect (is-var? ex1) #f)
(check-expect (is-var? ex7) #t)
(check-expect (is-var? ex8) #t)

(define (is-var? ex)
  (cond [(symbol? ex) #true]
        [else #f]))


; Lam -> Boolean
; determines whether the given ex is a lambda expression.

(check-expect (is-λ? ex1) #t)
(check-expect (is-λ? ex3) #t)
(check-expect (is-λ? ex5) #f)
(check-expect (is-λ? ex7) #f)
(check-expect (is-λ? ex9) #f)

(define (is-λ? ex)
  (cond [(cons? ex)
         (and (= 3 (length ex))
              (equal? (first ex) 'λ)
              (andmap symbol? (second ex))
              (is-lam? (third ex)))]
        [else #false]))


; Lam -> Boolean
; determines whether the given ex is an application

(check-expect (is-app? ex5) #t)
(check-expect (is-app? ex6) #t)
(check-expect (is-app? ex9) #t)
(check-expect (is-app? ex8) #f)


(define (is-app? ex)
  (cond [(cons? ex)
         (and (= 2 (length ex))
              (andmap is-lam? ex))]
        [else #false]))


; Any -> Boolean
; determines whether the given x is an Lam.

(check-expect (is-lam? ex1) #t)
(check-expect (is-lam? ex7) #t)
(check-expect (is-lam? ex9) #t)

(define (is-lam? x)
  (or (is-var? x)
      (is-λ? x)
      (is-app? x)))


; Lam -> [List-of Symbol]
; produces all parameters of the given ex.

(check-expect (declareds ex1) '(x))
(check-satisfied (declareds ex6) (check-args '(x y)))

(define (declareds ex)
  (cond [(is-var? ex) '()]
        [(is-app? ex) (declareds (app-fun ex))]
        [(is-λ? ex) (cons (λ-para ex)
                          (declareds (λ-body ex)))]))


;; auxiliary functions
; Lam -> Symbol
; produces all parameters of the given ex.
; assuming (is-λ? ex) is #true.

(check-expect (λ-para ex1) 'x)
(check-expect (λ-para ex3) 'y)

(define (λ-para ex)
  (car (second ex)))


; Lam -> Lam
; produces the body of the given ex.
; assuming (is-λ? ex) is #true.

(check-expect (λ-body ex1) 'x)
(check-expect (λ-body ex3) '(λ (x) y))

(define (λ-body ex)
  (third ex))


; Lam -> Lam
; produces the function of the given app.
; assuming (is-app? app) is #true.

(check-expect (app-fun ex4) '(λ (x) (x x)))
(check-expect (app-fun ex6) '((λ (y) (λ (x) y)) (λ (z) z)))

(define (app-fun app)
  (first app))


; Lam -> Lam
; produces the arguments of the given app.

(check-expect (app-arg ex4) '(λ (x) (x x)))
(check-expect (app-arg ex6) '(λ (w) w))

(define (app-arg app)
  (second app))


;; check functions
; [List-of Symbol] -> [ [List-of Symbol] -> Boolean]
; produces a function to check if all the arguments are
; the member of los.

(define (check-args los)
  (lambda (l)
    (andmap (lambda (s) (member? s los)) l)))

