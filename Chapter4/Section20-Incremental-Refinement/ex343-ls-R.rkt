;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex343-ls-R) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; A Path is [List-of Symbol].
; interpretation directions into in a directory tree


;; constants
(define HOME "C:\\Users\\HuYibo\\Documents\\TotalData\\Host'sData")
(define PV (create-dir (string-append HOME "\\LearnVim\\PracticeVim")))
(define NETCAT (create-dir (string-append HOME "\\netcat")))
(define HTML (create-dir (string-append HOME "\\learnHTML")))
(define sample (make-dir 'TS
                         `(,(make-dir 'Text
                                      '()
                                      `(,(make-file 'part1 99 "")
                                        ,(make-file 'part2 52 "")
                                        ,(make-file 'part3 17 "")))
                           ,(make-dir 'Libs
                                      `(,(make-dir 'Code
                                                   '()
                                                   `(,(make-file 'hang 8 "")
                                                     ,(make-file 'draw 2 "")))
                                        ,(make-dir 'Docs
                                                   '()
                                                   `(,(make-file 'read! 19 ""))))
                                      '()))
                         `(,(make-file 'read! 10 ""))))


;; functions
; Dir -> [List-of Path]
; produces the list consist of all names of all files in given d.

(check-expect (ls-R sample)
              '((TS read!)
                (TS Text part1)
                (TS Text part2)
                (TS Text part3)
                (TS Libs Code hang)
                (TS Libs Code draw)
                (TS Libs Docs read!)))

(define (ls-R d)
  (local ((define head (dir-name d))
          (define add-head
            (lambda (path) (cons head path))))
    (map add-head (append (map (lambda (file) (list (file-name file)))
                               (dir-files d))
                          (foldl (lambda (sub base) (append base (ls-R sub)))
                                 '()
                                 (dir-dirs d))))))


;; auxiliary functions
;; do not use ...
; Dir -> [List-of Path]
; produces the list consist of all names of files and directories in given d.

(check-expect (ls-path sample) '((TS read!)
                                 (TS Text)
                                 (TS Libs)))
(check-expect (ls-path (make-dir 'Text
                                 '()
                                 `(,(make-file 'part1 99 "")
                                   ,(make-file 'part2 52 "")
                                   ,(make-file 'part3 17 ""))))
              '((Text part1)
                (Text part2)
                (Text part3)))

(define (ls-path d)
  (local ((define head (dir-name d))
          (define add-head
            (lambda (path) (cons head `(,path)))))
    `(,@(map add-head (map file-name (dir-files d)))
      ,@(map add-head (map dir-name (dir-dirs d))))))


; Dir -> [List-of Path]
; produces the list consist of all names of files in given d.

(check-expect (ls-file sample) '((TS read!)))
(check-expect (ls-file (make-dir 'Text
                                 '()
                                 `(,(make-file 'part1 99 "")
                                   ,(make-file 'part2 52 "")
                                   ,(make-file 'part3 17 ""))))
              '((Text part1)
                (Text part2)
                (Text part3)))

(define (ls-file d)
  (local ((define head (dir-name d))
          (define add-head
            (lambda (path) (cons head `(,path)))))
    (map add-head (map file-name (dir-files d)))))


