;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex228-find) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define-struct fs [fsm current])
; A SimulationState.v2 is a structure
;    (make-fs FSM FSM-State)

;; struct constants
(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")
(define BLACK "black")
(define WHITE "white")

(define fsm-traffic
  (list (make-transition "red" "green")
        (make-transition "green" "yellow")
        (make-transition "yellow" "red")))
(define fsm-bw
  (list (make-transition "black" "white")
        (make-transition "white" "black")))

;; main functions
; FSM FSM-State -> SimulationState.v2
; match the keys pressed with the given FSM
(define (simulate.v2 a-fsm s0)
  (big-bang (make-fs a-fsm s0)
            [to-draw state-as-colored-square]
            [on-key find-next-state]))


;; important functions
; SimulationState.v2 -> Image
; renders current world state as a colored square

(check-expect (state-as-colored-square (make-fs fsm-traffic "red"))
              (square 100 "solid" "red"))

(define (state-as-colored-square a-fs)
  (square 100 "solid" (fs-current a-fs)))


; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from ke and cs

(check-expect (find-next-state (make-fs fsm-traffic "red") "n")
              (make-fs fsm-traffic "green"))
(check-expect (find-next-state (make-fs fsm-traffic "red") "a")
              (make-fs fsm-traffic "green"))
(check-expect (find-next-state (make-fs fsm-traffic "green") "q")
              (make-fs fsm-traffic "yellow"))
(check-expect (find-next-state (make-fs fsm-traffic "yellow") "n")
              (make-fs fsm-traffic "red"))

(define (find-next-state a-fs ke)
  (make-fs (fs-fsm a-fs)
           (find (fs-fsm a-fs) (fs-current a-fs))))


;; auxiliary functions
; FSM-State FSM-State -> Boolean
; check if the given two states are equal.

(check-expect (state=? RED RED) #true)
(check-expect (state=? GREEN RED) #false)
(check-expect (state=? GREEN GREEN) #true)

(define (state=? s-1 s-2)
  (string=? s-1 s-2))


; FSM FSM-State -> FSM-State
; finds the state matching current in the table

(check-expect (find fsm-traffic RED) GREEN)
(check-expect (find fsm-traffic GREEN) YELLOW)
(check-expect (find fsm-traffic YELLOW) RED)
(check-error (find fsm-traffic "black"))

(define (find transitions current)
  (cond [(empty? transitions)
         (error (string-append "not found: " current))]
        [else (if (state=? current (transition-current (first transitions)))
                  (transition-next (first transitions))
                  (find (rest transitions) current))]))


;; launch program
;(simulate.v2 fsm-traffic RED)
;(simulate.v2 fsm-bw BLACK)





