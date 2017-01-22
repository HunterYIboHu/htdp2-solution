;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex341-du) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; consume the total size of all the fils in the entire directory.

(check-expect (du PV) 403)
(check-expect (du NETCAT) 265266)

(define (du d)
  (local (; [List-of Number] -> Number
          ; produces the sum of the given number list.
          (define (sum lon)
            (foldr + 0 lon)))
    (+ (sum (map file-size (dir-files d)))
       (sum (map du (dir-dirs d))))))

