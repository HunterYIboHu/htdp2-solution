;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex333-how-many-model2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct dir [name content])
; A Dir.v2 is a structure: 
;   (make-dir String LOFD)
 
; A LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String.


;; constants
(define TS (make-dir "TS" `("read!"
                            ,(make-dir "Text" '("part1" "part2" "part3"))
                            ,(make-dir "Libs" `(,(make-dir "Code" '("hang" "draw"))
                                                ,(make-dir "Docs" '("read!")))))))
(define test-1
  (make-dir "test-1" '()))
(define test-2
  (make-dir "test-2"
            `(,(make-dir "test-2-1" '())
              ,(make-dir "test-2-2" '("beatiful" "girls"))
              ,(make-dir "test-2-3"
                         `(,(make-dir "test-3-1" '()))))))


;; functions
; Dir.v2 -> Number
; produces the number of files contains in the given dir.

(check-expect (how-many TS) 7)
(check-expect (how-many test-1) 0)
(check-expect (how-many test-2) 2)

(define (how-many dir)
  (foldr + 0 (map (lambda (d) (if (string? d) 1 (how-many d)))
                  (dir-content dir))))

