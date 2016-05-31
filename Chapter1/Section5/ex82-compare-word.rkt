;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex82-compare-word) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; LcL(short for Lower-case Letter) is one of:
; - "a" through "z"
; - "#false"


; This is the answer to ex78
; Word is (make-word LcL LcL LcL)
(define-struct word [l-1 l-2 l-3])

(define wd1 (make-word "a" "b" "c"))
(define wd2 (make-word "b" "t" "c"))


; LcL LcL -> LcL
; compare the two LcL, if equal, return it;
; else return #f
(define (compare-letter letter-1 letter-2)
  (if (equal? letter-1 letter-2) letter-1 #f))


; Word Word -> Word
; determine weather the two field of two words agree
; if agree, retains teh content of the field
; else puts #false in the field
; examples:
(check-expect (compare-word wd1 wd1)
              (make-word (compare-letter (word-l-1 wd1)
                                         (word-l-1 wd1))
                         (compare-letter (word-l-2 wd1)
                                         (word-l-2 wd1))
                         (compare-letter (word-l-3 wd1)
                                         (word-l-3 wd1))))
(check-expect (compare-word wd1 wd2)
              (make-word (compare-letter (word-l-1 wd1)
                                         (word-l-1 wd2))
                         (compare-letter (word-l-2 wd1)
                                         (word-l-2 wd2))
                         (compare-letter (word-l-3 wd1)
                                         (word-l-3 wd2))))

(define (compare-word word-a word-b)
  (make-word (compare-letter (word-l-1 word-a)
                             (word-l-1 word-b))
             (compare-letter (word-l-2 word-a)
                             (word-l-2 word-b))
             (compare-letter (word-l-3 word-a)
                             (word-l-3 word-b))))

(compare-word wd1 wd2)












