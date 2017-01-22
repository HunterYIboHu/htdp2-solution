;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex262-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; functions
; N -> [List-of [List-of N]]
; consume N and produces an identity matrices of order N

(check-expect (identityM 1) `(,'(1)))
(check-expect (identityM 3) '((1 0 0) (0 1 0) (0 0 1)))
(check-expect (identityM 5) '((1 0 0 0 0) (0 1 0 0 0) (0 0 1 0 0) (0 0 0 1 0) (0 0 0 0 1)))

(define (identityM n)
  (local ((define NUM 1)
          (define origin (make-list n (make-list (sub1 n) 0)))
          ; N [List-of N] -> [List-of N]
          ; insert NUM on the given position of given list.
          (define (insert pos l)
            (cond [(= pos 0) (cons NUM l)]
                  [else (cons (first l)
                              (insert (sub1 pos) (rest l)))]))
          ; N [List-of [List-of N]]
          ; produce an identity matrice of order n
          (define (helper num l)
            (cond [(empty? l) '()]
                  [else (cons (insert (sub1 num) (first l))
                              (helper (sub1 num) (rest l)))])))
    (reverse (helper n origin))))

