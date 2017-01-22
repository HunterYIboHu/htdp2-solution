;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname specifying-with-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; [X X -> Boolean] -> [ [List-of X] -> Boolean ]
; produces a function that determines whether
; some list is sorted according to cmp.

(check-expect [(sorted string<?) '("b" "c")] #true)
(check-expect [(sorted <) '(1 2 3 4 5 6)] #true)
(check-expect [(sorted >) '(1 4 52 2 3)] #false)
(check-expect [(sorted <=) '()] #true)

(define (sorted cmp)
  (lambda (l0)
    (local (; [NEList-of X] -> Boolean
            ; is l sorted according to cmp
            (define (sorted/l l)
              (cond [(empty? (rest l)) #true]
                    [else (and (cmp (first l) (second l))
                               (sorted/l (rest l)))])))
      (if (empty? l0) #true (sorted/l l0)))))


; [X X -> Boolean] -> [ [List-of X] -> Boolean ]
; produces a function that determines whether
; some list is sorted according to cmp.

(check-expect [(sorted.v2 string<?) '("b" "c")] #true)
(check-expect [(sorted.v2 <) '(1 2 3 4 5 6)] #true)
(check-expect [(sorted.v2 >) '(1 4 52 2 3)] #false)
(check-expect [(sorted.v2 <=) '()] #true)

(define (sorted.v2 cmp)
  (lambda (l0)
    (sorted? cmp l0)))


; [List-of X] [X X -> Boolean] -> [[List-of X] -> Boolean]
; is l0 sorted according to cmp
; are all items in list k members of list l0.

(check-expect [(sorted-variant-of '(3 2) <) '(2 3)] #true)

(define (sorted-variant-of k cmp)
  (lambda (l0)
    (and (sorted? cmp l0)
         (contains? l0 k)
         (contains? k l0))))


;; auxiliary functions
; [X X -> Boolean] [NEList-of X] -> Boolean
; determine whether l is sorted according to cmp.

(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(2 1 3)) #false)

(define (sorted? cmp l)
  (cond [(or (empty? l) (empty? (rest l))) #true]
        [else (and (cmp (first l) (second l))
                   (sorted? cmp (rest l)))]))


; [List-of X] [List-of X] -> Boolean
; are all items in list k members of list l

(check-expect (contains? '(1 2 3) '(1 4 3)) #false)
(check-expect (contains? '(1 2 3 4) '(1 3)) #true)

(define (contains? l k)
  (andmap (lambda (item) (member? item l)) k))


;; Question
;; Q1: This is your first function-producing function. Read the definition again.
;; Can you explain this definition in your own words?
;;
;; A1: The definition shows the function consume a list and produce a Boolean value.
;;
;;
;; Q2: Could you re-define sorted to use sorted? from exercise 292?
;; A2: Yes I can, and the reuslt is all above.
;;
;;
;; Q3: Explain why sorted/l does not consume cmp as an argument?
;; A3: For the cmp function do not change all over the time, and it's the argument
;; received by surrounded function, there is no necessarity to consume it.













