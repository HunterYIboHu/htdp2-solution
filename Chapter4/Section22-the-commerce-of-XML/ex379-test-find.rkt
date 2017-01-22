;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex379-test-find) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


; A FSM is a [List-of 1Transition]
; A 1Transition is a list of two items:
;    (list FSM-State FSM-State)
; A FSM-State is a String that specifies a color

; data examples
(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))


; FSM FSM-State -> FSM-State
; match the keys pressed by a player with the given FSM
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
            [to-draw (lambda (current)
                       (overlay/align "left" "top"
                                      (text current 12 "black")
                                      (square 100 "solid" current)))]
            [on-key (lambda (current key-event)
                      (find transitions current))]))

; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist

(check-expect (find '((1 "one") (2 "two")) 2) "two")
(check-expect (find '(("one" "red") ("two" "blue")) "one") "red")
(check-error (find '(("one" 1) ("two" 2)) "three") "not found")

(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))


;; launch program
;(simulate "red" fsm-traffic)