;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex294-is-index) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in l, #false otherwise

(check-satisfied (index 2 '(0 1 2)) (is-index? 2 '(0 1 2)))
(check-satisfied (index "sad" '("sad" "not" "real" "sad"))
                 (is-index? "sad" '("sad" "not" "real" "sad")))
(check-satisfied (index "sad" '("not" "read"))
                 (is-index? "sad" '("not" "read")))

(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))


; X [List-of X] -> [ [Maybe N] -> Boolean ]
; determine the result is correct, it satisfied these conditions:
; 1. when given #false, l doesn't contain the given x
; 2. when given N, l contains the given x and the N is the first occurence.
; 3. the given index's item is the item we need.
; 4. the given index is legal, means it's a legal range.

(check-expect [(is-index? 2 '(0 1 2)) 2] #true)
(check-expect [(is-index? 2 '(0 1 2)) 1] #false)
(check-expect [(is-index? 2 '(0 1 1 2 2)) 3] #true)
(check-expect [(is-index? 2 '(0 1 1 2 2)) 4] #false)
(check-expect [(is-index? 2 '(0 1 1 1)) #false] #true)
(check-expect [(is-index? 2 '(0 1 1 1)) 1] #false)

(define (is-index? x l)
  (lambda (maybe-n)
    (cond [(false? maybe-n) (not (member? x l))]
          [else (and (member? x l)
                     (equal? x (list-ref l maybe-n))
                     (<= 0 maybe-n (sub1 (length l)))
                     (not (member? x (extract-before maybe-n l))))])))


; N [List-of X] -> [List-of X]
; the given pos is legal index.

(check-expect (extract-before 5 '(1 2 3 4 5 6 7 8 9)) '(1 2 3 4 5))
(check-expect (extract-before 2 '(#false #true #false)) '(#false #true))

(define (extract-before pos lox)
  ((lambda (l) (build-list pos (lambda (n) (list-ref l n)))) lox))