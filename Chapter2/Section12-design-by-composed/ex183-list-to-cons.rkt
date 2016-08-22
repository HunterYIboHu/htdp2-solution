;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex183-list-to-cons) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; only use cons expr
(check-expect (cons "a" (list 0 #false))
              (cons "a" (cons 0 (cons #false '()))))
(check-expect (list (cons 1 (cons 13 '())))
              (cons (cons 1 (cons 13 '())) '()))
(check-expect (cons (list 1 (list 13 '())) '())
              (cons (cons 1
                          (cons
                           (cons 13
                                 (cons '()
                                       '()))
                                '()))
                    '()))
(check-expect (list '() '() (cons 1 '()))
              (cons '()
                    (cons '()
                          (cons (cons 1 '())
                                '()))))
(check-expect (cons "a" (cons (list 1) (list #false '())))
              (cons "a" (cons (cons 1 '()) (cons #false (cons '() '())))))


;; only use list expr

(check-expect (cons "a" (list 0 #false))
              (list "a" 0 #false))
(check-expect (list (cons 1 (cons 13 '())))
              (list (list 1 13)))
(check-expect (cons (list 1 (list 13 '())) '())
              (list (list 1 (list 13 '()))))
(check-expect (list '() '() (cons 1 '()))
              (list '() '() (list 1)))
(check-expect (cons "a" (cons (list 1) (list #false '())))
              (list "a" (list 1) #false '()))



