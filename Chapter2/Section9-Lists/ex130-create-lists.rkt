;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex130-create-lists) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; a list of planets in our solar system, I prefer Chinese~
(define solar-system
  (cons "太阳"
        (cons "水星"
              (cons "金星"
                    (cons "地球"
                          (cons "火星"
                                (cons "木星"
                                      (cons "土星"
                                            (cons "天王星"
                                                  (cons "海王星"
                                                        '()))))))))))

(define meals
  (cons "steak"
        (cons "French fries"
              (cons "beans"
                    (cons "bread"
                          (cons "water"
                                (cons "cheese"
                                      (cons "ice cream"
                                            '()))))))))

(define colors
  (cons "red"
        (cons "blue"
              (cons "green"
                    (cons "black"
                          (cons "white"
                                (cons "pink"
                                      (cons "orange"
                                            '()))))))))















