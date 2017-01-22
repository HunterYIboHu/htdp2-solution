;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex517-struct-undeclareds) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Lambda is one of:
; - Variable
; - Lam
; - Application

; A Variable is a Symbol.

(define-struct lam [para body])
; A Lam is (make-lam Parameter Body)
; A Parameter is one of :
; - Symbol
; - '()
; A Body is one of:
; - Symbol
; - Lam

(define-struct app [fun arg])
; A Application is (make-app Lam Lam)


;; constants
(define S '*undeclared)


;; data examples
(define ex1 (make-lam 'x 'x))
(define ex2 (make-lam 'x 'y))
(define ex3 (make-lam 'y (make-lam 'x 'y)))
(define ex4 'x)
(define ex5 (make-app (make-lam 'x (make-lam 'x 'x))
                      (make-lam 'x (make-lam 'x 'x))))
(define ex6 (make-app (make-lam 'x (make-lam 'y (make-app 'y 'x)))
                      (make-lam 'z 'z)))


;; functions
; Lambda -> Lambda
; replace all symbols in le0 with `(*undeclared(S) ,s) if
; they do not exist within the parameters of the λ
; term.
; other symbols will replaced with `(*declared ,s).

(check-expect (undeclareds ex1)
              (make-lam 'x '*declared:x))
(check-expect (undeclareds ex2)
              (make-lam 'x '*undeclared:y))
(check-expect (undeclareds ex3)
              (make-lam 'y (make-lam 'x '*declared:y)))
(check-expect (undeclareds ex4) '*undeclared:x)
(check-expect (undeclareds ex5)
              (make-app
               (make-lam 'x (make-lam 'x '*declared:x))
               (make-lam 'x (make-lam 'x '*declared:x))))
(check-expect (undeclareds ex6)
              (make-app (make-lam 'x
                                  (make-lam 'y
                                            (make-app '*declared:y
                                                      '*declared:x)))
                        (make-lam 'z '*declared:z)))


(define (undeclareds le0)
  (local (; Symbol Symbol -> Symbol
          (define (add-symbol state v)
            (string->symbol
             (apply string-append
                    (map symbol->string `(,state : ,v)))))
          ; Lambda [List-of Symbol] -> Lambda
          ; accumulator declareds represents all parameters of
          ; the given le that occurred before.
          (define (undeclareds/a le declareds)
            (cond [(var? le)
                   (if (member? le declareds)
                       (add-symbol '*declared le)
                       (add-symbol S le))]
                  [(lam? le)
                   (local ((define para (lam-para le))
                           (define body (lam-body le))
                           (define newd (cons para declareds)))
                     (make-lam para (undeclareds/a body newd)))]
                  [(app? le)
                   (make-app (undeclareds/a (app-fun le) declareds)
                             (undeclareds/a (app-arg le) declareds))])))
    (undeclareds/a le0 '())))


;; auxiliary functions
; Lambda -> Boolean
; determines whether the given ex is an Variable.

(check-expect (var? ex4) #t)
(check-expect (var? 'y) #t)
(check-expect (var? ex1) #f)

(define (var? ex)
  (symbol? ex))









