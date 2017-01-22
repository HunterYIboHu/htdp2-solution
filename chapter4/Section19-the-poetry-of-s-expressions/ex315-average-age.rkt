;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex315-average-age) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


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

; Pyhsical constants
(define CURRENT 2016)


;; functions
; [List-of FT] N -> N
; produces the average age of all child instance in the forest,
; assuming that the trees in the given forest don't overlap.

(check-expect (average-age ff1 CURRENT) 90)
(check-expect (average-age ff2 CURRENT) 70.25)

(define (average-age a-ff current)
  (local ((define (sum l)
            (foldr + 0 l)))
    (/ (sum (map (lambda (ft) (sum-age ft current)) a-ff))
       (sum (map count-persons a-ff)))))



;; auxiliary functions
; FT -> Number
; counts the child structures in a-ftree.

(check-expect (count-persons Carl) 1)
(check-expect (count-persons Eva) 3)
(check-expect (count-persons Gustav) 5)

(define (count-persons a-ftree)
  (match a-ftree
    [(? no-parent?) 0]
    [(child fa mo n d e) (+ (count-persons fa)
                            (count-persons mo)
                            1)]))


; FT Number -> Number
; produces the total age of all child in a-ftree, assuming that
; they all alive now.

(check-expect (sum-age Carl CURRENT) 90)
(check-expect (sum-age Eva CURRENT) 231)
(check-expect (sum-age Gustav CURRENT) 309)

(define (sum-age a-ftree current)
  (match a-ftree
    [(? no-parent?) 0]
    [(child fa mo n d e) (+ (sum-age fa current)
                            (sum-age mo current)
                            (- current d))]))
