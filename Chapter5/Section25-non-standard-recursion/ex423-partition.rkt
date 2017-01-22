;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex423-partition) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String N -> [List-of String]
; produces a list of string chunks of size n.
; when n is 0, it causes continuable recursion. 

(check-expect (partition "abc" 1)
              '("a" "b" "c"))
(check-expect (partition "abc" 2)
              '("ab" "c"))
(check-expect (partition "abc" 3)
              '("abc"))
(check-expect (partition "abc" 5)
              '("abc"))
(check-expect (partition "" 5) '())

(define (partition s n)
  (cond [(string=? s "") '()]
        [else (cons (take-string s n)
                    (partition (drop-string s n) n))]))


; String N -> String
; take the first n characters of the given s.

(check-expect (take-string "abc" 0) "")
(check-expect (take-string "" 3) "")
(check-expect (take-string "abc" 1) "a")
(check-expect (take-string "abc" 4) "abc")

(define (take-string s n)
  (cond [(or (string=? "" s) (zero? n)) ""]
        [(> n (string-length s)) (substring s 0 (string-length s))]
        [else (substring s 0 n)]))


; String N -> [List-of String]
; drop the first n characters of the given s.

(check-expect (drop-string "" 5) "")
(check-expect (drop-string "abc" 0) "abc")
(check-expect (drop-string "abc" 5) "")
(check-expect (drop-string "abc" 2) "c")

(define (drop-string s n)
  (cond [(zero? n) s]
        [(or (string=? "" s) (>= n (string-length s))) ""]
        [else (substring s n)]))


;; auxiliary functions
; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n.
; when n is 0, it causes continuable recursion.

(check-expect (bundle (explode "abcdefgh") 2)
              '("ab" "cd" "ef" "gh"))
(check-expect (bundle (explode "abcdefgh") 3)
              '("abc" "def" "gh"))
(check-expect (bundle '("a" "b") 3)
              '("ab"))
(check-expect (bundle '() 3) '())

(define (bundle s n)
  (cond [(empty? s) '()]
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


;; check function
; String N -> [ [List-of String] -> Boolean ]
; produces a function to determine the given los is satisfied.

(check-satisfied (partition "abc" 1)
                 (check-partition "abc" 1))
(check-satisfied (partition "abc" 2)
                 (check-partition "abc" 2))
(check-satisfied (partition "abc" 3)
                 (check-partition "abc" 3))
(check-satisfied (partition "abc" 5)
                 (check-partition "abc" 5))
(check-satisfied (partition "" 5)
                 (check-partition "" 5))

(define (check-partition s n)
  (lambda (los) (equal? los
                        (bundle (explode s) n))))

