;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname in-number) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write mixed-fraction #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define in-str "hello")
(define in-num 42)
(define in-bool #false)
(define in-img (rectangle 20 10 "outline" "black"))

; 函数
(define (in->number in)
  (cond [(string? in) (string-length in)]
        [(number? in) (sub1 in)]
        [(boolean? in) (if (boolean=? #true in)
                           10
                           20)]
        [(image? in) (* (image-width in)
                        (image-height in))]))

; 测试
"string test"
(in->number in-str)
"number test"
(in->number in-num)
"boolean test"
(in->number in-bool)
"image test"
(in->number in-img)


                
