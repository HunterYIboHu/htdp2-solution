;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex319-substitute) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; S-expr Symbol Symbol -> S-expr

(check-expect (substitute '(hello world) 'hello 'goodbye)
              '(goodbye world))
(check-expect (substitute '(define no-parent "") 'define 'define-struct)
              '(define-struct no-parent ""))
(check-expect (substitute '(((hello) world) goodbye) 'world 'sekai)
              '(((hello) sekai) goodbye))
(check-expect (substitute 123 'hello 'hi)
              123)
(check-expect (substitute "hello" 'hello 'hi)
              "hello")
(check-expect (substitute '(((world) hello) hello) 'hello 'hi)
              '(((world) hi) hi))

(define (substitute s-expr old new)
  (cond [(atom? s-expr) (local (; Atom Symbol Symbol -> Atom
                                ; produces new if at equals old.
                                (define (sub/atom at old new)
                                  (cond [(number? at) at]
                                        [(string? at) at]
                                        [(symbol? at)
                                         (if (symbol=? at old) new at)])))
                          (sub/atom s-expr old new))]
        [else (local (; SL Symbol Symbol -> SL
                      ; substitue all the occurences of old in the sl with
                      ; new, and produces the resulted sl.
                      (define (sub/sl sl old new)
                        (cond [(empty? sl) '()]
                              [else (cons (substitute (first sl) old new)
                                          (sub/sl (rest sl) old new))])))
                (sub/sl s-expr old new))]))


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