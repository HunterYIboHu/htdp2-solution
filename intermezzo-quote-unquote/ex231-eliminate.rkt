;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex231-eliminate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; eliminate quote with list
(check-expect '(1 "a" 2 #false 3 "c")
              (list 1 "a" 2 #false 3 "c"))
(check-expect '()
              (list ))
(check-expect '(("alan" 1000)
                ("barb" 2000)
                ("carl" 1500)
                ("dawn" 2300))
              (list (list "alan" 1000)
                    (list "barb" 2000)
                    (list "carl" 1500)
                    (list "dawn" 2300)))


;; eliminate list with cons
(check-expect '(1 "a" 2 #false 3 "c")
              (cons 1 (cons "a" (cons 2 (cons #false (cons 3 (cons "c" '())))))))
(check-expect '(("alan" 1000)
                ("barb" 2000)
                ("carl" 1500)
                ("dawn" 2300))
              (cons (cons "alan" (cons 1000 '()))
                    (cons (cons "barb" (cons 2000 '()))
                          (cons (cons "carl" (cons 1500 '()))
                                (cons (cons "dawn" (cons 2300 '()))
                                      '())))))