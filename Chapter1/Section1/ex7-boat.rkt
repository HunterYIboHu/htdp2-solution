;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname boat) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define left-tri
  (triangle/sas 30 90 40 "solid" "blue"))
(define right-tri
  (triangle/ass 90 30 40 "solid" "blue"))
(define mid-rec
  (rectangle 60 30 "solid" "red"))

(define left-part
  (overlay/xy left-tri
              40 0
              mid-rec))
(define boat
  (overlay/xy left-part
              100 0
              right-tri))
; 显示船只
boat