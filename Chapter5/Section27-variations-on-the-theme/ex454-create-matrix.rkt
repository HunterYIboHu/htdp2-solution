;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex454-create-matrix) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define lon-1 '(1 2 3 4))
(define lon-2 '(1 2 3 4 5 6 7 8 9))

(define matrix-1 '((1 2)
                   (3 4)))
(define matrix-2 '((1 2 3)
                   (4 5 6)
                   (7 8 9)))


;; functions
; N [List-of Number] -> [List-of [List-of Number]]
; prodcues a n x n matrix which is represented as list of list.
; assume (1) the given lon's length is (sqr n)
; (2) the result consists of n list whose length is n.

(check-expect (create-matrix 2 lon-1) matrix-1)
(check-expect (create-matrix 3 lon-2) matrix-2)

(define (create-matrix num l)
  (local (; N [List-of Number] -> [List-of [List-of Number]]
          ; help create matrix by unregularly create lol.
          (define (create-matrix/auxi n lon)
            (cond [(empty? lon) '()]
                  [else (cons (first-line n lon)
                              (create-matrix/auxi
                               n
                               (remove-first-line n lon)))])))
  (create-matrix/auxi num l)))


;; auxiliary functions
; N [List-of Number] -> [List-of Number]
; produces the first n items of the given list.

(check-expect (first-line 2 lon-1) '(1 2))
(check-expect (first-line 3 lon-2) '(1 2 3))

(define (first-line n lon)
  (cond [(or (zero? n)
             (empty? lon)) '()]
        [else (cons (first lon)
                    (first-line (sub1 n) (rest lon)))]))


; N [List-of Number] -> [List-of Number]
; produces the list which is removed the first n items.

(check-expect (remove-first-line 2 lon-1) '(3 4))
(check-expect (remove-first-line 3 lon-2) '(4 5 6 7 8 9))
(check-expect (remove-first-line 2 '(3 4)) '())

(define (remove-first-line n lon)
  (cond [(or (zero? n)
             (empty? lon)) lon]
        [else (remove-first-line (sub1 n) (rest lon))]))

