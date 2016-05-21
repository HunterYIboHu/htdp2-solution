;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname boolean-test) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define sunny #true)
(define friday #false)
; 函数
(define (go-to-mall condition)
  (cond [(and #true condition) "A:'Sunny!Let\'s go to mall!'"]
        [(not condition) "A:'I don\'t like go out in Friday~'"]))

; 测试
"Q:'Would you like to go to mall?'"
(go-to-mall sunny)
(go-to-mall friday)