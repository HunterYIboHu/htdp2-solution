;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex504-rotate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data examples
(define test-1 (append (make-list 999 '(0 9 3)) '((1 4 10))))
(define test-2 (append (make-list 9999 '(0 9 3)) '((1 4 10))))


;; functions
; Matrix -> Matrix 
; find a row that doesn't start with 0 and
; use it as the first one
; generative move the first row to last place 
; no termination if all rows start with 0

(check-expect (rotate '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))
(check-error (rotate '((0 1 2) (0 4 5) (0 6 2))))

(define (rotate M)
  (cond [(andmap (lambda (row) (zero? (first row))) M)
         (error "All rows start with 0!")]
        [(not (= (first (first M)) 0)) M]
        [else
         (rotate (append (rest M) (list (first M))))]))


; Matrix -> Matrix 
; find a row that doesn't start with 0 and
; use it as the first one
; it signals error when M0's all rows start with 0.

(check-expect (rotate.v2 '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))
(check-error (rotate.v2 '((0 4 5) (0 98 3))))

(define (rotate.v2 M0)
  (local (; Martix Row -> Matrix
          ; produces the rotated matrix whose
          ; first row is not starts with 0.
          ; accumulator seen 
          (define (rotate/a M seen)
            (cond [(not (= (first (first M)) 0)) (append M seen)]
                  [else (rotate/a (rest M)
                                  (cons (first M) seen))]))
          )
    (if (andmap (lambda (row) (zero? (first row))) M0)
        (error "All rows start with 0!")
        (rotate/a M0 '()))))


;; test
"(rotate test-1) 1,000 items"
(time (first (rotate test-1)))

"(rotate.v2 test-1) 1,000 items"
(time (first (rotate.v2 test-1)))

"(rotate.v2 test-2) 10,000 items"
(time (first (rotate.v2 test-2)))



