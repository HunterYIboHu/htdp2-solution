;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex339-find) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; Dir String -> Number
; determine whether or not a file with the given fn occurs in the d.

(check-expect (find? HTML 'test_img.jpg) #true)
(check-expect (find? NETCAT 'nc.exe) #true)
(check-expect (find? HTML '幸德秋水.jpg) #true)
(check-expect (find? PV `do-not-exist) #false)

(define (find? d fn)
  (or (member? fn (map file-name (dir-files d)))
      (ormap (lambda (a-dir) (find? a-dir fn)) (dir-dirs d))))




