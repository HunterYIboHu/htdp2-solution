;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex132-boolean-list) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A List-of-booleans is one of:
; - '()
; - (cons Boolean List-of-booleans)
; interpretation a List-of-booleans represents a list of values
; by Boolean.

; examples:

(define bool-1
  (cons #false
        (cons #true
              (cons #false
                    '()))))

(define bool-2
  (cons #false '()))

(define bool-e '())

bool-1
bool-2
bool-e