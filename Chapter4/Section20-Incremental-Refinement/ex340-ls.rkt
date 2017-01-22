;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex340-ls) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; Dir -> [List [List-of File] [List-of Dir]]
; produces the list consist of all names of files and directories in given d.

(check-expect (ls PV) '((0_mechanics.txt
                         1_copy_content.txt
                         2_foo_bar.js
                         3_concat.js
                         env
                         s_gvim.ps1
                         s_gvim.ps1~)
                        ()))

(define (ls d)
  `(,(map file-name (dir-files d))
    ,(map dir-name (dir-dirs d))))





















