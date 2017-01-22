;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex431-articulate-key-question) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Questions
;; Q1: For bundle, what is a trivially solvable problem?
;; A1: When the input is an empty list, or
;; the given n is larger than the list's length.
;;
;; Q2: For bundle, how are trivial solutions solved?
;; A2: If the input is an empty list, then produces another empty list;
;; If the input N is larger than the length of list, then produces a
;; list contains a string which is combined by all the 1String of the
;; origin one.
;;
;; Q3: (For bundle) How does the algorithm generate new problems that
;; are more easily solvable than the original one? 
;; Is there one new problem that we generate or are there several?
;; A3: To take apart the given list by two auxiliary functions. And for
;; that, there is one new problem generated.
;;
;; Q4: (For bundle) Is the solution of the given problem the same as
;; the solution of (one of) the new problems? Or, do we need to
;; combine the solutions to create a solution for the original problem?
;; And, if so, do we need anything from the original problem data?
;; A4: We need to combine the solutions to create a solution for the
;; original problem, and we need the original list and the number for
;; the original one.
;;
;; Q5: (For quick-sort) What is a trivially solvable problem?
;; A5: When the input is an empty list, or an one-item list.
;;
;; Q6: (For quick-sort) How are trivial solutions solved?
;; A6: If the input is an empty list or one-item list, it just return
;; it.
;;
;; Q7: (For quick-sort) How does the algorithm generate new problems
;; that are more easily solvable than the original one? 
;; Is there one new problem that we generate or are there several?
;; A7: Use two auxiliary function to split the given list into three
;; part; the pivot, the list contains all the numbers less than the
;; pivot, the list contains all the numbers larger than the pivot.
;; There is two new problem we generate.