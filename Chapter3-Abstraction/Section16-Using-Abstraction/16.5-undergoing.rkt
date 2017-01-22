;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 16.5-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Sample Problem Design add-3-to-all. The function consumes a list of Posns
;; and adds 3 to the x-coordinates of each.


; [List-of Posn] -> [List-of Posn]
; adds 3 to each x-coordinate on the given list

(check-expect (add-3-to-all `(,(make-posn 30 10) ,(make-posn 0 0)))
              `(,(make-posn 33 10) ,(make-posn 3 0)))

(define (add-3-to-all lop)
  (local (; Posn -> Posn
          ; adds 3 to the x-coordinate of p
          (define (add-3-to-1 p)
            (make-posn (+ 3 (posn-x p)) (posn-y p))))
    (map add-3-to-1 lop)))


;; Sample Problem Design a function that eliminates all Posns from a list
;; that have a y-coordinate of larger than 100.


; [List-of Posn] -> [List-of Posn]
; eliminates Posns whose y-coordinate is > 100

(check-expect (keep-good `(,(make-posn 0 110) ,(make-posn 0 60)))
              `(,(make-posn 0 60)))
(check-expect (keep-good `(,(make-posn 0 100))) `(,(make-posn 0 100)))

(define (keep-good lop)
  (local (; Posn -> Boolean
          ; should this Posn stay on the list
          (define (good? p)
            (<= (posn-y p) 100)))
    (filter good? lop)))


;; Question
;; Q1: why the helper function consumes individual Posns and
;; produces Booleans?
;; A1: Because the filter's signature shows that the helper *p?*'s
;; signature should be [X -> Boolean], and the X here is Posn.


;; Sample Problem Design a function that determines whether any of
;; a list of Posns is close to some given position pt
;; where “close” means a distance of at most 5 pixels.4


; [List-of Posn] Posn -> Boolean
; is any Posn on lop close to pt

(check-expect (close? `(,(make-posn 47 54) ,(make-posn 0 60))
                      (make-posn 50 50)) #true)
(check-expect (close? `(,(make-posn 100 100) ,(make-posn 0 -30))
                      (make-posn 0 0)) #false)

(define (close? lop pt)
  (local ((define CLOSENESS 5)
          ; Posn -> Boolean
          ; is one shot close to pt.
          (define (is-one-close? p)
            (close-to p pt CLOSENESS)))
    (ormap is-one-close? lop)))


;; auxiliary functions
; Posn Posn Number -> Boolean
; is the distance between p and q less than d

(check-expect (close-to (make-posn 0 5) (make-posn 0 0) 5) #true)
(check-expect (close-to (make-posn 0 5) (make-posn 0 0) 4) #false)
(check-expect (close-to (make-posn 2 5) (make-posn 5 3) 5) #true)

(define (close-to p q d)
  (>= d (sqrt (+ (sqr (- (posn-x p) (posn-x q)))
                 (sqr (- (posn-y p) (posn-y q)))))))

