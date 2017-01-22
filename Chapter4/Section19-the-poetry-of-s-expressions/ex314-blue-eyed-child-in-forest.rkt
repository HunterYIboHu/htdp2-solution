;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex314-blue-eyed-child-in-forest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct no-parent [])
(define NP (make-no-parent))
(define-struct child [father mother name date eyes])
; A FT (short for family tree) is one of: 
; – NP
; – (make-child FT FT String N String)

; A FF (short for family forest) is [List-of FT]
; interpretation a family forest represents several
; families (say a town) and their ancestor trees


;; constants
; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; Family forests
(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))


;; functions
; [List-of FT] -> Boolean
; does the forest contains any child with "blue" eyes

(check-expect (blue-eyed-child-in-forest? ff1) #false)
(check-expect (blue-eyed-child-in-forest? ff2) #true)
(check-expect (blue-eyed-child-in-forest? ff3) #true)

(define (blue-eyed-child-in-forest? a-ff)
  (ormap blue-eyed-child? a-ff))


;; auxiliary functions
; FT -> Boolean
; does a-ftree contain a child structure with "blue" in the eyes field.

(check-expect (blue-eyed-child? Carl) #false)
(check-expect (blue-eyed-child? Eva) #true)
(check-expect (blue-eyed-child? Gustav) #true)

(define (blue-eyed-child? a-ftree)
  (cond [(no-parent? a-ftree) #false]
        [else (or (blue-eyed-child? (child-father a-ftree))
                  (blue-eyed-child? (child-mother a-ftree))
                  (string=? "blue"(child-eyes a-ftree)))]))




