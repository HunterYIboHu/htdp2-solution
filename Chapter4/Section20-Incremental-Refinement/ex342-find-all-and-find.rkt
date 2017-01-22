;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex342-find-all-and-find) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; A Path is [List-of String].
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
; Dir Symbol -> [Maybe Path]
; produces a path to a file with name f if (find? d f) is #true; else produces
; #false.

(check-expect (find NETCAT 'nc.exe)
              '(|C:\Users\HuYibo\Documents\TotalData\Host'sData\netcat|
                nc.exe))
(check-expect (find HTML 'test_img.jpg)
              '(|C:\Users\HuYibo\Documents\TotalData\Host'sData\learnHTML|
                test_img.jpg))
(check-expect (find PV 'do-not-exist) #false)
(check-expect (find HTML '幸德秋水.jpg)
              '(|C:\Users\HuYibo\Documents\TotalData\Host'sData\learnHTML|
                |C:\Users\HuYibo\Documents\TotalData\Host'sData\learnHTML\第四章：文本|
                |C:\Users\HuYibo\Documents\TotalData\Host'sData\learnHTML\第四章：文本\网页|
                幸德秋水.jpg))
(check-expect (find sample 'part1) (list 'TS 'Text 'part1))

(define (find d fn)
  (cond [(find? d fn)
         `(,(dir-name d)
           ,@(if (member? fn (map file-name (dir-files d)))
                 `(,fn)
                 (find (first (filter (lambda (a-dir) (find? a-dir fn))
                                      (dir-dirs d)))
                       fn)))]
        [else #false]))


; Dir Symbol -> [List-of Path]
; produces a list of path to a file with name f if (find? d f) is #true; else produces
; '().

(check-expect (find-all sample 'read!) '((TS read!)
                                     (TS Libs Docs read!)))
(check-expect (find-all sample 'part1) '((TS Text part1)))
(check-expect (find-all sample 'do-not-exist) '())

(define (find-all d f)
  (local ((define head
            (dir-name d))
          ; [ Path -> Path ]
          (define add-head
            (lambda (path)
              (cons head path))))
    ; - IN -
    (append (if (symbol=? f head)
                (list (list f))
                '())
            (map add-head (find-all-in-files (dir-files d) f))
            (map add-head (find-all-in-dirs (dir-dirs d) f)))))


; [List-of File] Symbol -> [List-of [List-of Symbol]]
; produces the list of list which contains the file named the given f;
; otherwise produces #false.

(check-expect (find-all-in-files `(,(make-file 'part1 99 "")
                                   ,(make-file 'part2 52 "")
                                   ,(make-file 'part3 17 ""))
                                 'part1)
              `((part1)))
(check-expect (find-all-in-files `(,(make-file 'part1 99 "")
                                   ,(make-file 'part2 52 "")
                                   ,(make-file 'part3 17 ""))
                                 'part4)
              '())

(define (find-all-in-files lof f)
  (if (ormap (lambda (file)
               (symbol=? f (file-name file)))
             lof)
      (list (list f))
      '()))


; [List-of Dir] Symbol -> [List-of [List-of Symbol]]
; produces all the paths contains the given file in the given dir.

(check-expect (find-all-in-dirs `(,(make-dir 'Code
                                             '()
                                             `(,(make-file 'hang 8 "")
                                               ,(make-file 'draw 2 "")))
                                  ,(make-dir 'Docs
                                             '()
                                             `(,(make-file 'read! 19 ""))))
                                'hang)
              '((Code hang)))
(check-expect (find-all-in-dirs `(,(make-dir 'Code
                                             '()
                                             `(,(make-file 'hang 8 "")
                                               ,(make-file 'draw 2 "")))
                                  ,(make-dir 'Docs
                                             '()
                                             `(,(make-file 'read! 19 "")
                                               ,(make-file 'hang 9 ""))))
                                'hang)
              '((Code hang)
                (Docs hang)))

(define (find-all-in-dirs lod f)
  (cond
    [(empty? lod) '()]
    [else
     (append (find-all (first lod) f)
             (find-all-in-dirs (rest lod) f))]))


;; auxiliary functions
; Dir Symbol -> Number
; determine whether or not a file with the given fn occurs in the d.

(check-expect (find? HTML 'test_img.jpg) #true)
(check-expect (find? NETCAT 'nc.exe) #true)
(check-expect (find? HTML '幸德秋水.jpg) #true)
(check-expect (find? PV `do-not-exist) #false)

(define (find? d fn)
  (or (member? fn (map file-name (dir-files d)))
      (ormap (lambda (a-dir) (find? a-dir fn)) (dir-dirs d))))




