;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1string) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write mixed-fraction #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 函数
; ex15
(define (string-first str)
  (string-ith str 0))
  
  
; ex16
(define (string-last str)
  (string-ith str
             (- (string-length str)
                1)))

; 测试
(format "~a的第一个字符为~s" "Hello" (string-first "Hello"))
(format "~a的最后一个字符为~s" "Hello" (string-last "Hello"))
