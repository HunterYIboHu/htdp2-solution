;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex67-structure-type) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
(define-struct person [name hair eyes phone])
(define-struct pet [name number])
(define-struct CD [artist title price])
(define-struct sweater [meterial size producer])

(define mv1
  (make-movie "天下第一" "陈凯歌" "2010"))
(define per1
  (make-person "胡一波" "绿色" "黄色" "19934567"))
(define pet1
  (make-pet "李狗蛋" "123465"))
(define CD1
  (make-CD "黑猫乐队" "光辉岁月" "199$"))
(define SW1
  (make-sweater "棉质" "M" "五星"))
