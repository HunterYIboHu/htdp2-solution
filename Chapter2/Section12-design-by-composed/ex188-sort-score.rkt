;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex188-sort-score) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct gp [name score])
; A GamePlayer is a structure:
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who scored
; a maximum of s points

(define gp1 (make-gp "Matthew" 1000))
(define gp2 (make-gp "John" 2000))
(define gp3 (make-gp "Scala" 3000))


; A LOG is one of:
; - '()
; - (cons GamePlayer LOG)

;; main functions
; LOG -> LOG
; produces a sorted list of gameplayer, the list is sorted by score
; in descending order.

(check-expect (sort<score '()) '())
(check-expect (sort<score (list gp1)) (list gp1))
(check-expect (sort<score (list gp2 gp1 gp3)) (list gp3 gp2 gp1))

(define (sort<score alog)
  (cond [(empty? alog) '()]
        [else (insert<score (first alog) (sort<score (rest alog)))]))


;; auxiliary functions
; GamePlayer LOG -> LOG
; insert a gp into the sorted list of game players, the list is sorted by
; player's score in descending order.

(check-expect (insert<score gp2 '()) (list gp2))
(check-expect (insert<score gp2 (list gp1)) (list gp2 gp1))
(check-expect (insert<score gp2 (list gp3)) (list gp3 gp2))
(check-expect (insert<score gp2 (list gp3 gp1)) (list gp3 gp2 gp1))

(define (insert<score agp alog)
  (cond [(empty? alog) (list agp)]
        [else (if (>= (gp-score agp)
                      (gp-score (first alog)))
                  (cons agp alog)
                  (cons (first alog) (insert<score agp (rest alog))))]))

