;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname string-module-presudo) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write mixed-fraction #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 函数
; ex20
(define (string-join str-1 str-2)
  (string-append str-1 "_" str-2))


; ex21
; 检查字符串长度是否大于零，以及位置是否超过字符串长度。
; 是则进行插入，不是则返回单个_
(define (string-insert str pos)
  (if (and (> (string-length str) 0)
           (> (string-length str) pos))
   (string-append (substring str 0 pos)
                 "_"
                 (substring str
                            (+ pos 1)
                            (string-length str)))
   "_"))

(string-insert "Hello world" 5)
(string-insert "" 3)
                            
