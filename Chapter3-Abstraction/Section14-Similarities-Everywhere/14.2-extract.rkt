;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 14.2-extract) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; main functions

(check-expect (extract < '() 5) (small '() 5))
(check-expect (extract < '(3) 5) (small '(3) 5))
(check-expect (extract < '(1 6 4) 5) (small '(1 6 4) 5))

(define (extract R l t)
  (cond [(empty? l) '()]
        [else (cond
                [(R (first l) t)
                 (cons (first l)
                       (extract R (rest l) t))]
                [else (extract R (rest l) t)])]))


;; auxiliary functions
; Lon Number -> Lon
; select those numbers on l
; that are below t
(define (small l t)
  (cond
    [(empty? l) '()]
    [else
     (cond
       [(< (first l) t)
        (cons (first l)
          (small
            (rest l) t))]
       [else
        (small
          (rest l) t)])]))


; Lon Number -> Lon
; select those numbers on l
; that are above t
(define (large l t)
  (cond
    [(empty? l) '()]
    [else
     (cond
       [(> (first l) t)
        (cons (first l)
          (large
            (rest l) t))]
       [else
        (large
          (rest l) t)])]))


;; re-define the above two function -- small and large -- with extract
; Lon Number -> Lon
; selete those numbers on l that below t

(check-expect (small.v2 '() 5) '())
(check-expect (small.v2 '(3) 5) '(3))
(check-expect (small.v2 '(1 6 4 2) 4) '(1 2))

(define (small.v2 l t)
  (extract < l t))


; Lon Number -> Lon
; selete those numbers on l that above t

(check-expect (large.v2 '() 5) '())
(check-expect (large.v2 '(3) 5) '())
(check-expect (large.v2 '(1 5 3 4 6 7) 5) '(6 7))

(define (large.v2 l t)
  (extract > l t))