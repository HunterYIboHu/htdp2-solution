;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex389-zip) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct phone-record [name number])
; A PhoneRecord is a structure:
;   (make-phone-record String String).


;; constants
(define pr1 (make-phone-record "John" "6722543"))
(define pr2 (make-phone-record "Matthew" "2574339"))


;; functions
; [List-of String] [List-of String] -> [List-of PhoneRecord]
; produces the list of pr by the according name and phone numbers.

(check-expect (zip '() '()) '())
(check-expect (zip '("John") '("6722543")) `(,pr1))
(check-expect (zip '("John" "Matthew") '("6722543" "2574339"))
              `(,pr1 ,pr2))

(define (zip names phones)
  (cond [(empty? names) '()]
        [else (cons (make-phone-record (first names)
                                       (first phones))
                    (zip (rest names) (rest phones)))]))