;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname image) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 定义
(define 7polygon
  (star-polygon 40 7 1 "solid" "darkgon"))
(define sta
  (star 20 "solid" "red"))
(define cir
  (circle 5 "solid" "blue"))

; 运行
; (overlay 7polygon sta cir)
; (overlay cir sta 7polygon)
; (overlay sta cir 7polygon)
(overlay/align "right" "bottom"
               (rectangle 20 20 "solid" "sliver")
               (rectangle 30 30 "solid" "seagreen")
               (rectangle 40 40 "solid" "sliver")
               (rectangle 50 50 "solid" "seagreen"))

