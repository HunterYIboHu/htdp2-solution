;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex164-convert-euro) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define USD/EUR 0.8908)


;; data difition
; A List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)

(define US-TWO (cons 100 (cons 20 '())))
(define US-FIVE (cons 100
                      (cons 20
                            (cons 40
                                  (cons 30
                                        (cons 55 '()))))))


;; main function
; List-of-numbers -> List-of-numbers
; convert the given list of US$ to correspond list of EURO€

(check-expect (convert-euro* '()) '())
(check-expect (convert-euro* US-TWO)
              (cons (convert-euro 100)
                    (cons (convert-euro 20) '())))
(check-expect (convert-euro* US-FIVE)
              (cons (convert-euro 100)
                    (cons (convert-euro 20)
                          (cons (convert-euro 40)
                                (cons (convert-euro 30)
                                      (cons (convert-euro 55) '()))))))

(define (convert-euro* alous)
  (cond [(empty? alous) '()]
        [(cons? alous) (cons (convert-euro (first alous))
                             (convert-euro* (rest alous)))]))


;; auxilliary function
; Number -> Number
; conver the given US$ to correspond EURO€

(check-expect (convert-euro 100) (* USD/EUR 100))
(check-expect (convert-euro 20) (* USD/EUR 20))
(check-expect (convert-euro 0) 0)

(define (convert-euro us)
  (* USD/EUR us))