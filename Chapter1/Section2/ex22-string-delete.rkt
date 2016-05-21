;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex4-string-delete) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define str "helloworld")
(define i 5)
(define short-str "hello")

; 函数
(define (string-delete s pos)
  (string-append (substring s 0 pos)
                 (substring s (+ pos 1))))
; 这里需要给函数做一个检查，两个类型检查和一个长度检查
; 运行
(string-delete str i)

; fails! This function can't deal with empty string.
(string-delete "" 0)