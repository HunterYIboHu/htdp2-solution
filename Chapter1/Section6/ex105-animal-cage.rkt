;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex105-animal-cage) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct spider [legs space])
(define-struct elephant [space])
(define-struct boa-constrictor [length girth])
(define-struct armadillo [legs space])

; Animal is one of:
; - Sipder
; - Elephant
; - Boa constrictor
; - armadillo
; interpretation the attributes of these animal in zoo.
(define a-spi (make-spider 8 10))
(define a-ele (make-elephant 5000))
(define a-boa (make-boa-constrictor 100 20))
(define a-arm (make-armadillo 4 2000))


; physical constant
(define CAGE-S 200)
(define CAGE-M 3000)
(define CAGE-L 8000)


; Animal Number -> Boolean
; determine weather the cage's volume Number
; is large enough for the animal.
; examples:
(check-expect (fits? a-spi CAGE-S) #true)
(check-expect (fits? a-ele CAGE-M) #false)
(check-expect (fits? a-boa CAGE-L) #true)
(check-expect (fits? a-arm CAGE-M) #true)
(check-expect (fits? "String" 100) #false)

(define (fits? ani v)
  (cond [(spider? ani)
         (<= (spider-space ani) v)]
        [(elephant? ani)
         (<= (elephant-space ani) v)]
        [(boa-constrictor? ani)
         (<= (* (boa-constrictor-length ani)
                (boa-constrictor-girth ani))
             v)]
        [(armadillo? ani)
         (<= (armadillo-space ani) v)]
        [else #false]))