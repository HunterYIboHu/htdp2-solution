;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex468-reform-triangulate-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; A TM is a [List-of Equation]
; such that the Equations are of decreasing length:
;    n + 1, n, n - 1, ..., 2.
; interpretation represents a triangular matrix.


;; constants
(define M ; an SOE
  '((2 2 3 10) ; an Equation
    (2 5 12 31)
    (4 1 -2 1)))
(define M-2 ; M after triangulation transform
  '((2 2 3 10)
    (0 3 9 21)
    (0 0 1 2)))
(define M-3 ; M put 0 on the first column after 1st row.
  '((2 2 3 10)
    (0 3 9 21)
    (0 -3 -8 -19)))
(define M-4
  '((2 3 3 8)
    (2 3 -2 3)
    (4 -2 2 4)))
(define M-5
  '((2 3 3 8)
    (0 -8 -4 -12)
    (0 0 -5 -5)))

(define S '(1 1 2)) ; a Solution
(define S-2 '(1 1 1))


;; functions
; SOE -> TM
; triangulates the given system of equations
; when encounter a matrix whose first item of every row is zero,
; signals an error.

(check-expect (triangulate M)
              '((2 2 3 10)
                (3 9 21)
                (1 2)))
(check-expect (triangulate '((3 9 21)
                             (-3 -8 -19)))
              '((3 9 21)
                (1 2)))
(check-expect (triangulate '((1 2)))
              '((1 2)))
(check-expect (triangulate M-4)
              '((2 3 3 8)
                (-8 -4 -12)
                (-5 -5)))
(check-error (triangulate '((0 1 2) (0 4 5))))

(define (triangulate matrix)
  (cond [(empty? (rest matrix)) matrix]
        [(andmap (lambda (l) (zero? (first l))) matrix)
         (error "All of equations start with 0.")]
        [else (local ((define maybe-result
                        (map (lambda (e)
                               (subtract (first matrix) e))
                             (rest matrix)))
                      ; [List-of [List-of Number]] ->
                      ; [List-of [List-of Number]]
                      ; if the first item on the first row is 0,
                      ; then rotate it and recursive
                      ; otherwise, just return it.
                      (define (get-result r)
                        (if (zero? (first (first r)))
                            (get-result (rotate r))
                            r))
                      ; [List-of Any] -> [List-of Any]
                      ; subtract the first item to the end of list.
                      ; assume list is non-empty.
                      (define (rotate l)
                        (append (rest l) (list (first l))))
                      )
                (cons (first matrix)
                      (triangulate (get-result maybe-result))))]))


; Equation Equation -> Equation
; subtracts the second from the first, item by item, as many times as
; necessary to obtain an Equation with 0 at first position.
; and return the rest of the second Equation.

(check-expect (subtract '(2 2 3 10) '(2 5 12 31))
              '(3 9 21))
(check-expect (subtract '(2 2 3 10) '(4 1 -2 1))
              '(-3 -8 -19))
(check-expect (subtract '(3 9 21) '(-3 -8 -19))
              '(1 2))
(check-expect (subtract '(-3 9 21) '(6 5 10))
              '(-13 -32))
(check-error (subtract '(0 -5 -5) '(6 5 10)))

(define (subtract 1st-e 2nd-e)
  (local ((define head (first 2nd-e)))
    (cond [(zero? (first 1st-e)) (error "Divide by 0 is impossible.")]
          [(zero? head) (rest 2nd-e)]
          [else (subtract 1st-e
                          (map (lambda (a b) (if (> 0 head)
                                                 (+ a (abs b))
                                                 (- a (abs b))))
                               2nd-e 1st-e))])))


; SOE Solution -> Boolean
; determine whether plugging in the numbers from s for the variables
; in Equations of soe produces equal left-hand side value and right-hand
; side value;
; otherwise produces #false.

(check-expect (check-solution M S) #t)
(check-expect (check-solution M-2 S) #t)
(check-expect (check-solution M-3 S) #t)
(check-expect (check-solution M-4 S-2) #t)
(check-expect (check-solution M-5 S-2) #t)

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


