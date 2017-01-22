;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex477-arrangements) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [List-of X] -> [List-of [List-of X]]
; creates a list of all rearrangements of the items in w
(define (arrangements w)
  (cond
    [(empty? w) '(())]
    [else
      (foldr (lambda (item others)
               (local ((define without-item
                         (arrangements (remove item w)))
                       (define add-item-to-front
                         (map (lambda (a) (cons item a))
                              without-item)))
                 (append add-item-to-front others)))
        '()
        w)]))
 
(define (all-words-from-rat? w)
  (and (member (explode "rat") w)
       (member (explode "art") w)
       (member (explode "tar") w)))
 
(check-satisfied (arrangements '("r" "a" "t"))
                 all-words-from-rat?)


;; Questions
;; Q1: What is a trivially solvable problem?
;; A1: when w is an empty list.
;;
;; Q2: How are trivial solutions solved?
;; A2: it returns '(()).
;;
;; Q3: How does the algorithm generate new problems that are
;; more easily solvable than the original one?
;; Is there one new problem that we generate or are there several?
;; A3: To generate new problem, the algorithm turn to cut the list of
;; [List-of X]; every time the new problem deal with a smaller list.
;; We generate 1 new problem -- the problem is like the origin one,
;; but deal with a smaller one.
;;
;; Q4: Is the solution of the given problem the same as the solution
;; of (one of) the new problems? Or, do we need to combine the
;; solutions to create a solution for the original problem?
;; And, if so, do we need anything from the original problem data?
;; A4: The new problem is the same kind problem as the origin one.
;; We do need the items on the given input of the origin problem.
;;
;; Q5: the program would terminate for any input?
;; A5: Yes! The program would cut the length of list, and when the list
;; is empty, the program will terminate.
;;
;; Q6: Does arrangements in figure 165 create the same lists as the
;; solution of Word Games, the Heart of the Problem?
;; A6: No. This version's result is:
;;(list
;; (list "r" "a" "t")
;; (list "r" "t" "a")
;; (list "a" "r" "t")
;; (list "a" "t" "r")
;; (list "t" "r" "a")
;; (list "t" "a" "r"))
;; And the original version's result is:
;;(list
;; (list "r" "a" "t")
;; (list "a" "r" "t")
;; (list "a" "t" "r")
;; (list "r" "t" "a")
;; (list "t" "r" "a")
;; (list "t" "a" "r"))



