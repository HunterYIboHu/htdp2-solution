;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex233-eliminate-unquote-splice) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; eliminate ,@ operations use list.
(check-expect `(0 ,@'(1 2 3) 4) (list 0 1 2 3 4))
(check-expect `(("alan" ,(* 2 500))
                ("barb" 2000)
                (,@'("carl" " , the great") 1500)
                ("dawn" 2300))
              (list (list "alan" 1000)
                    (list "barb" 2000)
                    (list "carl" " , the great" 1500)
                    (list "dawn" 2300)))
(check-expect `(html
                (body
                 (table ((border "1"))
                        (tr ((width "200"))
                            ,@(make-row '(1 2)))
                        (tr ((width "200"))
                            ,@(make-row '(99 65))))))
              (list 'html
                    (list 'body
                          (list 'table (list (list 'border "1"))
                                (list 'tr
                                      (list (list 'width "200"))
                                      (list 'td "1")
                                      (list 'td "2"))
                                (list 'tr
                                      (list (list 'width "200"))
                                      (list 'td "99")
                                      (list 'td "65"))))))


;; auxiliary functions
; List-of-numbers -> ... nested list ...
; creates a row for an HTML table from L

(check-expect (make-row '(1 2)) '((td "1") (td "2")))
(check-expect (make-row '(3 5 10)) '((td "3") (td "5") (td "10")))
(check-expect (make-row '()) '())

(define (make-row l)
  (cond [(empty? l) '()]
        [else (cons (make-cell (car l))
                    (make-row (cdr l)))]))


; Number -> ... nested list ...
; creates a cell for an HTML table from a number

(check-expect (make-cell 1) '(td "1"))
(check-expect (make-cell 10) '(td "10"))
(check-expect (make-cell -10) '(td "-10"))

(define (make-cell n)
  `(td ,(number->string n)))