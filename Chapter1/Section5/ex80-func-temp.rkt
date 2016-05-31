;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex80-func-temp) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Movie -> Null
; consume a mv then write in to a file named the movie's name

(define (write-movie mv)
  (... (movie-title mv)
   ... (movie-director mv)
   ... (movie-year mv)))


; Person -> Null
; consume a pr then write it's information to stdout

(define (show-person pr)
  (... (person-name pr)
   ... (person-hair pr)
   ... (person-eyes pr)
   ... (person-phone pr)))


; pet Number -> Boolean
; determine if the pet's number equals to the given one

(define (my-pet? pet num)
  (... (pet-number pet) ... num))


; CD Number -> Number
; determine the distance between the price of cd and what
; in your pocket

(define (CD-distance cd money)
  (... (CD-price cd) money))


; Sweater String -> Boolean
; determine weather the size of sw is mathc the given size s

(define (sweater-match? sw size)
  (... (sweater-size sw) size))

; You can complete it, that's all easy one.
; By YiboHu
