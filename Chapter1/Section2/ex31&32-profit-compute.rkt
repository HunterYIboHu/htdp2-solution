;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname profit-compute) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define INIT-PRICE 5.0)
(define INIT-ATTENDEES 120)

(define PRICE-CHANGE 0.1)
(define ATTENDEES-NUMBER-CHANGE 15)
(define FIXED-COST 180)
(define PER-ATT-COST 0.04)
(define PER-ATT-COST-2 1.5)


; 函数
; 要考虑这里的人不会有负数的情况出现……
(define (attendees ticket-price)
  (- INIT-ATTENDEES (* (- ticket-price INIT-PRICE)
                       (/ ATTENDEES-NUMBER-CHANGE PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* PER-ATT-COST
                   (attendees ticket-price))))

; 修改成本的定义
(define (cost-2 ticket-price)
  (* PER-ATT-COST-2
     (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

; 根据成本的定义的改变进行的收益改变
; ex32
(define (profit-2 ticket-price)
  (- (revenue ticket-price)
     (cost-2 ticket-price)))

; 测试
(define (show-result ticket-price)
  (format "~a's result is: ~s"
          (format "(profit-2 ~a)"
                  ticket-price)
          (profit-2 ticket-price)))

(show-result 3)
(show-result 4)
(show-result 5)
(format "The max is ~s" (max (profit-2 3)
                             (profit-2 4)
                             (profit-2 5)))
