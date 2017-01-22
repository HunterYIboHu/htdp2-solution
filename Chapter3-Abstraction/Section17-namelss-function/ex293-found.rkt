;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex293-found) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise

(check-satisfied (find 3 '(1 3 4)) (found? 3 '(1 3 4)))
(check-satisfied (find 3 '(1 2)) (found? 3 '(1 2)))

(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))


; X [List-of X] -> [ [Maybe [List-of X]] -> Boolean ]
; is there is any sublist of l that starts with x
; and the return sublist is the first one?
; and if don't found, return #false?

(check-expect [(found? 3 '(1 3 4)) '(3 4)] #t)
(check-expect [(found? 3 '(1 3 4)) '(4)] #f)
(check-expect [(found? 3 '(1 2 4)) #false] #t)
(check-expect [(found? 3 '(1 3 3 4)) '(3 3 4)] #t)
(check-expect [(found? 3 '(1 3 3 4)) '(3 4)] #f)
(check-expect [(found? 3 '(1 2 2 4)) '(2 2 4)] #f)

(define (found? x l)
  (lambda (maybe-list)
    (cond [(false? maybe-list) (not (member? x l))]
          [else (cond [(member? x l)
                       (equal? l (append (find-before x l) maybe-list))]
                      [else #false])])))


; X [List-of X] -> [Maybe [List-of X]]
; extract the sublist before the given x occur.

(check-expect (find-before 10 '(1 2 3 4 10 2)) '(1 2 3 4))

(define (find-before x l)
  (cond [(equal? x (first l)) '()]
        [else (cons (first l)
                    (find-before x (rest l)))]))

