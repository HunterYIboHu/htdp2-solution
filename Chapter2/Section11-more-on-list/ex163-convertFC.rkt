;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex163-convertFC) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; physical constants
(define PERCISION 0.001)

; FTemperature is Number more than -459
; CTemperature is Number more than -273
; List-of-ftemperatures is one of:
; - '()
; - (cons FTemperature List-of-ftemperatures)

(define FT-ONE (cons 100 '()))
(define FT-FIVE (cons 50
                      (cons 100
                            (cons 150
                                  (cons 200
                                        (cons 250 '()))))))

; List-of-ctemperatures is one of:
; - '()
; - (cons CTemperature List-of-ctemperatures)


;; main-function
; List-of-ftemperatures -> List-of-ctemperatures
; convert from alof to ct according to the formula.

(check-within (convertFC FT-ONE) (cons (convert 100) '()) PERCISION)
(check-within (convertFC FT-FIVE)
              (cons (convert 50)
                    (cons (convert 100)
                          (cons (convert 150)
                                (cons (convert 200)
                                      (cons (convert 250) '())))))
              PERCISION)

(define (convertFC alof)
  (cond [(empty? alof) '()]
        [(cons? alof) (cons (convert (first alof))
                            (convertFC (rest alof)))]))


;; auxilliary-function
; FTemperature -> CTemperature
; conver the given ft to ct by formula.

(check-expect (convert 50) 10)
(check-expect (convert 68) 20)
(check-error (convert -460))

(define (convert ft)
  (if (> ft -459)
      (/ (- ft 32) 1.8)
      (error "NumberUnexpected: the FTemperature shall over -459.")))





