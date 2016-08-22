;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex226-state=) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


;; data difinitions
; A FSM is one of:
; - '()
; - (cons Transition FSM)

(define-struct transition [current next])
; A Transition is a structure:
;    (make-transition FSM-State FSM-State)

; FSM-State is a Color

; interpretation A FSM repersents the transitions that a finite state machine
; can take from one state to another in reaction to key strokes


;; struct constants
(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")


;; main functions
; FSM-State FSM-State -> Boolean
; check if the given two states are equal.

(check-expect (state=? RED RED) #true)
(check-expect (state=? GREEN RED) #false)
(check-expect (state=? GREEN GREEN) #true)

(define (state=? s-1 s-2)
  (string=? s-1 s-2))




