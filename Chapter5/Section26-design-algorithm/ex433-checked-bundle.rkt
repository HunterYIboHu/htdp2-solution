;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex433-checked-bundle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n.
; termination (bundle s 0) loops unless s is '().

(check-expect (bundle (explode "abcdefgh") 2)
              '("ab" "cd" "ef" "gh"))
(check-expect (bundle (explode "abcdefgh") 3)
              '("abc" "def" "gh"))
(check-expect (bundle '("a" "b") 3)
              '("ab"))
(check-expect (bundle '() 3) '())
(check-expect (bundle '() 0) '())
(check-error (bundle (explode "abc") 0))

(define (bundle s n)
  (cond [(empty? s) '()]
        [(zero? n)
         (error "the function won't terminate when n is given 0.")]
        [else (cons (implode (take s n))
                    (bundle (drop s n) n))]))


; [List-of X] N -> [List-of X]
; keep the first n items from l is possible or everything.
(define (take l n)
  (cond [(zero? n) '()]
        [(empty? l) '()]
        [else (cons (first l)
                    (take (rest l) (sub1 n)))]))


; [List-of X] N -> [List-of X]
; remove the first n items from l if possible or everything.
(define (drop l n)
  (cond [(zero? n) l]
        [(empty? l) l]
        [else (drop (rest l) (sub1 n))]))
