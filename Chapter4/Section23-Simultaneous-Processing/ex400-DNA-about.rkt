;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex400-DNA-about) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data difinitions
; A DNA is one of:
; - 'a
; - 'c
; - 'g
; - 't


; N is one of: 
; – 0
; – (add1 N)


;; constants
(define dna-1 '(a c g))
(define dna-2 '(a c g g t c a a a))
(define dna-3 '(a g t c a t))
(define dna-4 '(a g t c))

(define l1 '(1 2 3))
(define l2 '(1 2 3 4 5))


;; functions
; [List-of DNA] [List-of DNA] -> Boolean
; produces #true if the pattern is same as the initial part of the st;
; otherwise produces #false.

(check-expect (DNAprefix '() '()) #true)
(check-expect (DNAprefix '() dna-1) #true)
(check-expect (DNAprefix dna-1 '()) #false)
(check-expect (DNAprefix dna-1 dna-2) #true)
(check-expect (DNAprefix dna-4 dna-3) #true)
(check-expect (DNAprefix dna-1 dna-3) #false)

(define (DNAprefix pattern st)
  (cond [(empty? pattern) #true]
        [(empty? st) #false]
        [else (equal? pattern (take (length pattern) st))]))


; [List-of DNA] [List-of DNA] -> [Maybe DNA]
; produces the first item in the st beyond the pattern.
; if the lists are identical and there is no DNA letter beyond pattern,
; signals an error;
; if the pattern does not match the beginning of the st, it returns #false.

(check-error (DNAdelta '() '()))
(check-error (DNAdelta dna-1 dna-1))
(check-expect (DNAdelta '() dna-1) (first dna-1))
(check-expect (DNAdelta dna-1 '()) #false)
(check-expect (DNAdelta dna-1 dna-2) (fourth dna-2))
(check-expect (DNAdelta dna-4 dna-3) (fifth dna-3))
(check-expect (DNAdelta dna-4 dna-2) #false)

(define (DNAdelta pattern st)
  (cond [(and (empty? pattern) (empty? st))
         (error "No DNA letter beyond pattern.")]
        [(and (empty? pattern) (cons? st)) (first st)]
        [(and (cons? pattern) (empty? st)) #false]
        [else
         (local ((define len-of-p (length pattern))
                 (define rest-st (drop len-of-p st))
                 (define pattern-satisfied (equal? pattern (take len-of-p st))))
           (cond [(and pattern-satisfied (empty? rest-st))
                  (error "No DNA letter beyond pattern.")]
                 [pattern-satisfied (first rest-st)]
                 [else #false]))]))


;; auxiliary functions
; N [List-of Number] -> [List-of Number]
; produces the first n items from l or all of l is l is too short.

(check-expect (take 0 '()) '())
(check-expect (take 0 l1) '())
(check-expect (take 3 '()) '())
(check-expect (take 3 l2) '(1 2 3))
(check-expect (take 6 l2) l2)

(define (take n l)
  (cond [(and (> n 0) (cons? l))
         (cons (first l) (take (sub1 n) (rest l)))]
        [else '()]))


; N [List-of Number] -> [List-of Number]
; produces a list with the first n items removed or just '() if l is too short.

(check-expect (drop 0 '()) '())
(check-expect (drop 0 l1) l1)
(check-expect (drop 3 l2) '(4 5))
(check-expect (drop 3 l1) '())

(define (drop n l)
  (cond [(= n 0) l]
        [(empty? l) '()]
        [else (drop (sub1 n) (rest l))]))