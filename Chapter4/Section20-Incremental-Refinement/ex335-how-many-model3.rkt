;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex335-how-many-model3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
(define-struct file [name size content])
; A File.v3 is a structure: 
;   (make-file String N String)

(define-struct dir.v3 [name dirs files])
; A Dir.v3 is a structure: 
;   (make-dir.v3 String [List-of Dir.v3] [List-of File-.v3])


;; constants
(define CONTENT "")

(define TS (make-dir.v3 "TS"
                        `(,(make-dir.v3 "Text"
                                        '()
                                        `(,(make-file "part1" 99 CONTENT)
                                          ,(make-file "part2" 52 CONTENT)
                                          ,(make-file "part3" 17 CONTENT)))
                          ,(make-dir.v3 "Libs"
                                        `(,(make-dir.v3 "Code"
                                                     '()
                                                     `(,(make-file "hang" 8 CONTENT)
                                                       ,(make-file "draw" 8 CONTENT)))
                                          ,(make-dir.v3 "Docs"
                                                     '()
                                                     `(,(make-file "read!" 19 CONTENT))))
                                        '()))
                        `(,(make-file "read!" 10 CONTENT))))
(define test-1 (make-dir.v3 "test-1" '() '()))
(define test-2 (make-dir.v3 "test-2"
                            `(,(make-dir.v3 "test-2-1" '() '())
                              ,(make-dir.v3 "test-2-2"
                                            '()
                                            `(,(make-file "beautiful" 100 CONTENT)
                                              ,(make-file "girls" 99 CONTENT)))
                              ,(make-dir.v3 "test-2-3"
                                            `(,(make-dir.v3 "test-3-1" '() '()))
                                            '()))
                            '()))


;; functions
; Dir.v3 -> Number
; produces the number of files contains in the dir.
; version1

(check-expect (how-many TS) 7)
(check-expect (how-many test-1) 0)
(check-expect (how-many test-2) 2)

(define (how-many dir)
  (foldr + (length (dir.v3-files dir)) (map how-many (dir.v3-dirs dir))))


; Dir.v3 -> Number
; produces the number of files contains in the dir.
; version2

(check-expect (how-many.v2 TS) 7)
(check-expect (how-many.v2 test-1) 0)
(check-expect (how-many.v2 test-2) 2)

(define (how-many.v2 dir)
  (+ (length (dir.v3-files dir))
     (how-many-dir* (dir.v3-dirs dir))))


;; auxiliary functions
; Dir* -> Number
; process every dir.v3 in the given list, using how-many.v3.

(check-expect (how-many-dir* `(,(make-dir.v3 "test" '() '()))) 0)
(check-expect (how-many-dir* `(,(make-dir.v3 "test"
                                             `(,(make-dir.v3 "test-3"
                                                             '()
                                                             `(,(make-file "none" 10 CONTENT))))
                                             `(,(make-file "none-2" 20 CONTENT))))) 2)

(define (how-many-dir* alod)
  (cond [(empty? alod) 0]
        [else (+ (how-many (first alod))
                 (how-many-dir* (rest alod)))]))

