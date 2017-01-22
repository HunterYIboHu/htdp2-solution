;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex344-find-all-revised) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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


; Dir Symbol -> [List-of Path]
; produces the list consist of all path to file whose name is given one.

(check-expect (find-all sample 'read!) '((TS read!)
                                         (TS Libs Docs read!)))
(check-expect (find-all sample 'part1) '((TS Text part1)))
(check-expect (find-all sample 'do-not-exist) '())

(define (find-all d fn)
  (filter (lambda (files) (equal? fn (last-of files)))
          (ls-R d)))


;; auxiliary functions
; [List-of X] -> [Maybe X]
; produces the last item of the given list, else produces #false.

(check-expect (last-of '(1 2 3 4 5)) 5)
(check-expect (last-of '()) #false)

(define (last-of l)
  (local ((define last-index (sub1 (length l))))
    (if (= (length l) 0)
        #false
        (list-ref l last-index))))