;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex426-quick-sort-V2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; the hand evaluation of (quick-sort< (list 11 8 14 7))
;;
;;(quick-sort< (list 11 8 14 7))
;;==
;;(append (quick-sort< (list 8 7))
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (append (quick-sort< (list 7))
;;                 (list 8)
;;                (quick-sort< '()))
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (append (append (quick-sort< '())
;;                        (list 7)
;;                        (quick-sort< '()))
;;                (list 8)
;;                (quick-sort< '()))
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (append (append '()
;;                         (list 7)
;;                        '())
;;                (list 8)
;;                '())
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (append (list 7)
;;                (list 8)
;;                '())
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (list 7 8)
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (list 7 8 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (list 7 8 11)
;;        (append '()
;;                (list 14)
;;                '()))
;;==
;;(append (list 7 8 11)
;;        (list 14))
;;==
;;(list 7 8 11 14)


;; functions
; [List-of Number] -> [List-of Number]
; produces a sorted version of alon.

(check-expect (quick-sort<.v2 '(1 6 2 99 4 23))
              '(1 2 4 6 23 99))
(check-expect (quick-sort<.v2 '(10 40 30 20))
              '(10 20 30 40))
(check-expect (quick-sort<.v2 '()) '())

(define (quick-sort<.v2 alon)
  (cond [(empty? alon) '()]
        [(empty? (rest alon)) (list (first alon))]
        [else (local ((define pivot (first alon)))
                (append (quick-sort<.v2 (smallers alon pivot))
                        (list pivot)
                        (quick-sort<.v2 (largers alon pivot))))]))


;; auxiliary functions
; [List-of Number] Number -> [List-of Number]
; produces the numbers in the alon which is smaller than the given
; pivot.

(check-expect (smallers '(1 2 5 77 3 4) 4) '(1 2 3))
(check-expect (smallers '(1 2 5 77 3 4) 0) '())
(check-expect (smallers '() 0) '())

(define (smallers alon pivot)
  (filter (lambda (num) (< num pivot)) alon))


; [List-of Number] Number -> [List-of Number]
; produces the numbers in the alon which is larger than the given
; pivot.

(check-expect (largers '(1 2 5 77 3 4) 4) '(5 77))
(check-expect (largers '(1 2 5 77 3 4) 78) '())
(check-expect (largers '() 0) '())

(define (largers alon pivot)
  (filter (lambda (num) (> num pivot)) alon))


;; the hand evaluation of (quick-sort< (list 11 8 14 7)) after revised
;;(quick-sort< (list 11 8 14 7))
;;==
;;(append (quick-sort< (list 8 7))
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (append (quick-sort< (list 7))
;;                (list 8)
;;                (quick-sort< '()))
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (append (list 7)
;;                (list 8)
;;                (quick-sort< '()))
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (append (list 7)
;;                (list 8)
;;                '())
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (list 7 8)
;;        (list 11)
;;        (quick-sort< (list 14)))
;;==
;;(append (list 7 8)
;;        (list 11)
;;        (list 14))
;;==
;;(list 7 8 11 14)


;; cut down 3 step, the revised version cost 7 step,
;; the origin version cost 10 step.(count by "==")

;;(quick-sort<.v2 '(11 8 14 7)) cost 84 step.