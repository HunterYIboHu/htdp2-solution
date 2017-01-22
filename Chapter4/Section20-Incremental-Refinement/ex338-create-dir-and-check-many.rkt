;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex338-create-dir-and-check-many) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require htdp/dir)


;; data difinitions
;(struct dir (name dirs files)
;    #:extra-constructor-name make-dir)
;  name : symbol?
;  dirs : (listof dir?)
;  files : (listof file?)

;(struct file (name size content)
;    #:extra-constructor-name make-file)
;  name : symbol?
;  size : integer?
;  content : (listof char?)


;; constants
(define HOME "C:\\Users\\HuYibo\\Documents\\TotalData\\Host'sData")
(define PV (create-dir (string-append HOME "\\LearnVim\\PracticeVim")))
(define NETCAT (create-dir (string-append HOME "\\netcat")))
(define HTML (create-dir (string-append HOME "\\learnHTML")))


;; functions
; Dir -> Number
; produces the number of files contains in the dir.

(check-expect (how-many PV) 7)
(check-expect (how-many NETCAT) 10)
(check-expect (how-many HTML) 209)

(define (how-many dir)
  (foldr + (length (dir-files dir)) (map how-many (dir-dirs dir))))


;; Questions
;; Q1: Why are you confident that how-many produces correct results for these
;; directories?
;;
;; A1: Because the struct of dir and file is same as before, and the correctness
;; shall not change.