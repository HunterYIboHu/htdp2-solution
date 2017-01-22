;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex463-check-triangulation) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; definitions
; An SOE is an non-empty Matrix
; constraint for (list r1 ... rn), (length ri) is (+ n i)
; intepretation represents a system of linear equations

; An Equation is a [List-of Number]
; constraint an Equation contains at least two numbers.
; interpretation if (list a1 ... an b) is an Equation,
; a1, ..., an are the left-hand side variable coefficients
; and b is the right-hand side.

; A Solution is a [List-of Number]


;; constants
(define M ; an SOE
  '((2 2 3 10) ; an Equation
    (2 5 12 31)
    (4 1 -2 1)))
(define M-2 ; M after triangulation transform
  '((2 2 3 10)
    (0 3 9 21)
    (0 0 1 2)))

(define S '(1 1 2)) ; a Solution


;; functions
; SOE Solution -> Boolean
; determine whether plugging in the numbers from s for the variables
; in Equations of soe produces equal left-hand side value and right-hand
; side value;
; otherwise produces #false.

(check-expect (check-solution M S) #t)
(check-expect (check-solution M-2 S) #t)

(define (check-solution soe s)
  (cond [(empty? soe) #true]
        [else (local ((define 1st-e (first soe)))
                (and (= (rhs 1st-e)
                        (plug-in (lhs 1st-e) s))
                     (check-solution (rest soe) s)))]))


;; auxiliary functions
; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix.

(check-expect (lhs (first M)) '(2 2 3))

(define (lhs e)
  (reverse (rest (reverse e))))


; Equation -> Number
; extract the right-hand side from a row in a matrix.

(check-expect (rhs (first M)) 10)

(define (rhs e)
  (first (reverse e)))


; [List-of Number] Solution -> Number
; produces the value of left-hand side when the variable's
; value is s, and coffcients is loc.

(check-expect (plug-in (lhs (first M)) S) 10)
(check-expect (plug-in (lhs (second M)) S) 31)

(define (plug-in loc s)
  (foldr + 0
         (map (lambda (cof v) (* cof v))
              loc s)))

