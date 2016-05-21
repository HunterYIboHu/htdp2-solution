;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname car-for-excrise) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
(define wheel
  (overlay (circle 5 "solid" "black")
           (circle 10 "solid" "white")
           (circle 20 "solid" "black")))

(define part1
  (overlay/xy (rectangle 160 30 "solid" "black")
              0 30
              wheel))
(define part2
  (overlay/align "right" "bottom"
                 part1
                 wheel))
part2


