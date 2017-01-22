;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex521) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; PuzzleState -> PuzzleState
; is the final state reachable from state0
; generative create a tree of possible boat rides
; termination ???

(check-expect (solve initial-puzzle) final-puzzle)

(define (solve state0)
  (local (; [List-of PuzzuleState] -> PuzzleState
          ; generative generate the successors of los
          (define (solve* los)
            (cond [(ormap final? los)
                   (first (filter final? los))]
                  [else (solve* (create-next-states los))])
            ))
    (solve* (list state0))))


;; Questions
;; Q1: Because of this systematic way of traversing the tree, solve*
;; cannot go into an infinite loop. Why?
;;
;; A1: Because when some result start over, other way still usable.
;; This systemcatic way will create all ways, and stop at the first
;; final one.