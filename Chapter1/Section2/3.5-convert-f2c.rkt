;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname convert-f2c) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 函数
; 华氏温度转摄氏温度
(define (f2c f)
  (* 5/9 (- f 32)))

; 主函数
(define (convert in out)
  (write-file out
    (string-append
      (number->string
        (f2c
          (string->number
            (read-file in))))
      "\n")))

; 运行函数测试
(write-file "C:\\Users\\HuYibo\\Application\\HowtoDesignProgram\\第一章\\source\\test-convert-1.txt" "32")
(convert 
"C:\\Users\\HuYibo\\Application\\HowtoDesignProgram\\第一章\\source\\test-convert-1.txt"
 "C:\\Users\\HuYibo\\Application\\HowtoDesignProgram\\第一章\\source\\output-convert.txt-1")
