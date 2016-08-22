;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex234-render-html-table) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))


; List-of-strings -> ... deeply nested list ...
; produces a html table whose content is the ranked given list.

(check-expect (make-ranking one-list)
              '(table ((border "1"))
                      (tr (td "1")
                          (td "Asia: Heat of the Moment"))
                      (tr (td "2")
                          (td "U2: One"))
                      (tr (td "3")
                          (td "The White Stripes: Seven Nation Army"))))

(define (make-ranking los)
  `(table ((border "1"))
          ,@(make/auxi (ranking one-list))))


; List-of-list-of-strings -> ... nested list ...
; produce an xexpr for the HTML table with the given lls

(check-expect (make/auxi (ranking one-list))
              '((tr (td "1")
                    (td "Asia: Heat of the Moment"))
                (tr (td "2")
                    (td "U2: One"))
                (tr (td "3")
                    (td "The White Stripes: Seven Nation Army"))))

(define (make/auxi lls)
  (cond [(empty? lls) '()]
        [else (cons `(tr ,@(make-row (first lls)))
                    (make/auxi (rest lls)))]))


; List-of-strings -> ... nested list ...
; produce a HTML row with the given los

(check-expect (make-row '(1 "Asia: Heat of the Moment"))
              '((td "1") (td "Asia: Heat of the Moment")))
(check-expect (make-row '(3 "The White Stripes: Seven Nation Army"))
              '((td "3") (td "The White Stripes: Seven Nation Army")))

(define (make-row los)
  (cond [(empty? los) '()]
        [else (cons `(td ,(if (number? (first los))
                              (number->string (first los))
                              (first los)))
                    (make-row (rest los)))]))


;; auxiliary functions
(check-expect (ranking one-list)
              '((1 "Asia: Heat of the Moment")
                (2 "U2: One")
                (3 "The White Stripes: Seven Nation Army")))

(define (ranking los)
  (reverse (add-ranks (reverse los))))


(check-expect (add-ranks one-list)
              '((3 "Asia: Heat of the Moment")
                (2 "U2: One")
                (1 "The White Stripes: Seven Nation Army")))

(define (add-ranks los)
  (cond [(empty? los) '()]
        [else (cons (list (length los) (first los))
                    (add-ranks (rest los)))]))