;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex451-find-table) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; definitions
(define-struct table [length array])
; A Table is a structure:
;    (make-table N [N -> Number])


;; constants
(define TOLARANCE 0.001)


; N -> Number

(check-expect (a1 2) 6)
(check-error (a1 4))

(define (a1 i)
  (if (<= 0 i 3)
      (* i 3)
      (error "table1 is defined for i belongs to [0, 3]")))


; N -> Number

(check-within (a2 0) pi TOLARANCE)
(check-error (a2 1))

(define (a2 i)
  (if (zero? i)
      pi
      (error "table2 is not defined for i != 0")))


; N -> Number

(check-expect (a3 0) -8)
(check-expect (a3 2) 0)
(check-error (a3 1000))

(define (a3 i)
  (if (<= 0 i 100)
      (- (* i i i) 8)
      (error "table3 is defined for i belongs to [0, 100]")))


; N -> Number

(define (a4 i)
    (if (<= 0 i 10)
        (- (* i i i) 1001)
        (error "table4 is defined for i belongs to [0, 10]")))


; N -> Number

(define (a5 i)
  (if (<= 0 i 100)
      (- (* i i i) 123)
      (error "table4 is defined for i belongs to [0, 100]")))


(define table1 (make-table 4 a1))
(define table2 (make-table 1 a2))
(define table3 (make-table 101 a3))
(define table4 (make-table 11 a4))
(define table5 (make-table 101 a5))


;; functions
; Table -> N
; produces the smallest index for a root of the table.
; assume the given t is monotonically increasing.

(check-expect (find-linear table1) 0)
(check-expect (find-linear table2) 0)
(check-expect (find-linear table3) 2)
(check-expect (find-linear table4) 10)
(check-expect (find-linear table5) 5)

(define (find-linear t)
  (local ((define start-pair '(-1 +inf.0))
          ; [List N Number] -> Number
          ; produces the distance from the given pair's second
          ; value to the 0.
          (define (distance p) (abs (- (second p) 0)))
          ; Table N [List N Number]-> [List N Number]
          ; prodcues the minist index-value pair of the given table and index.
          (define (find-linear/auxi t i former)
            (cond [(= i (table-length t)) (first former)]
                  [else (local ((define current
                                  (list i (table-ref t i)))
                                (define next-pair
                                  (argmin distance `(,current ,former))))
                          (find-linear/auxi t (add1 i) next-pair))])))
    (find-linear/auxi t 0 start-pair)))


; Table -> N
; produces the smallest index for a root of the table.
; assume the given t is monotonicallly increasing.

(check-expect (find-binary table1) 0)
(check-expect (find-binary table2) 0)
(check-expect (find-binary table3) 2)
(check-expect (find-binary table4) 10)
(check-expect (find-binary table5) 5)

(define (find-binary t)
  (local ((define max-index (sub1 (table-length t)))
          ; N -> Number
          ; get the distance to zero of t on the given index i.
          (define (value i) (table-ref t i))

          (define t@left (value 0))
          (define t@right (value max-index))
          ; Table N N Number Number -> N
          ; produces the smallest index for a root of t.
          ; but use the bound value of the left and right.
          (define (find-binary/auxi t left right v-left v-right)
            (cond [(>= v-left 0) 0]
                  [(<= v-right 0) right]
                  [(<= (abs (- left right)) 1)
                   (first (argmin (lambda (v) (abs (second v)))
                                  `((,left ,v-left) (,right ,v-right))))]
                  ; help terminate the program.
                  [else (local ((define mid
                                  (round (/ (+ left right) 2)))
                                (define v-mid (value mid)))
                          (cond [(< v-mid 0 v-right)
                                 (find-binary/auxi t mid right v-mid v-right)]
                                [else (find-binary/auxi t left mid v-left v-mid)]))]))
          )
    (cond [(zero? max-index) 0]
          [else (find-binary/auxi t 0 max-index t@left t@right)])))


;; auxiliary functions
; Table N -> Number
; looks up the ith value in array of t

(check-expect (table-ref table1 1) 3)
(check-within (table-ref table2 0) pi TOLARANCE)
(check-error (table-ref table1 10))
(check-error (table-ref table4 100))

(define (table-ref t i)
  [(table-array t) i])

