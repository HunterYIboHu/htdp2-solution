;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname test-unknown) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


;; constants
(define SIZE 100)


;; data difinitions
(define-struct fsm [initial transitions final])
(define-struct transition [current next key])
; An FSM.v2 is a structure:
;    (make-fsm FSM-State LOT FSM-State)
; A LOT is one of:
; - '()
; - (cons Transition.v3 LOT)
; A Transition.v3 is a structure:
;    (make-transition FSM-State FSM-State KeyEvent)

; FSM-State is a Color

; interpretation A FSM repersents the transitions that
; a finite state machine can take from one state to another
; in reaction to key strokes


;; struct constants
(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")
(define WHITE "white")

(define AA (make-transition WHITE YELLOW "a"))
(define BC-1 (make-transition YELLOW YELLOW "b"))
(define BC-2 (make-transition YELLOW YELLOW "c"))
(define DD (make-transition YELLOW GREEN "d"))

(define STATES (list AA BC-1 BC-2 DD))
(define fsm-s (make-fsm WHITE STATES GREEN))
(define fsm-1 (make-fsm YELLOW STATES GREEN))
(define fsm-2 (make-fsm GREEN STATES GREEN))

;; main function
; FSM.v2 -> FSM.v2
(define (fsm-simulate a-fsm)
  (big-bang a-fsm
            [to-draw render]
            [on-key find-next-state]
            [stop-when stop?]))


;; important functions
; FSM.v2 -> Image
; render a fsm's current state as a colored square,
; the color repersents the current state.

(check-expect (render fsm-s) (square SIZE "solid" WHITE))
(check-expect (render fsm-1) (square SIZE "solid" YELLOW))
(check-expect (render fsm-2) (square SIZE "solid" GREEN))

(define (render a-fsm)
  (square SIZE "solid" (fsm-initial a-fsm)))


; FSM.v2 KeyEvent -> FSM.v2
; determine the next state of the given fsm according to the given key stroke

(check-expect (find-next-state fsm-s "a") fsm-1)
(check-expect (find-next-state fsm-1 "b") fsm-1)
(check-expect (find-next-state fsm-1 "c") fsm-1)
(check-expect (find-next-state fsm-1 "d") fsm-2)

(define (find-next-state a-fsm ke)
  (make-fsm (find (fsm-transitions a-fsm)
                  (fsm-initial a-fsm)
                  ke)
            (fsm-transitions a-fsm)
            (fsm-final a-fsm)))


; FSM.v2 -> Boolean
; determine whether the fsm should stop.
; if the initial-field of given fsm is same as the final-field, then
; return #true; otherwise return #false.

(check-expect (stop? fsm-s) #false)
(check-expect (stop? fsm-1) #false)
(check-expect (stop? fsm-2) #true)

(define (stop? a-fsm)
  (string=? (fsm-initial a-fsm)
            (fsm-final a-fsm)))


;; auxiliary functions
; LOT FSM-State KeyEvent -> FSM-State
; produces a state which is in the transition whose current is given state
; and key is the given ke.

(check-expect (find STATES WHITE "a") YELLOW)
(check-expect (find STATES YELLOW "b") YELLOW)
(check-expect (find STATES YELLOW "d") GREEN)
(check-error (find STATES YELLOW "a") "not found: yellow or a")

(define (find lot current ke)
  (cond [(empty? lot)
         (error (string-append "not found: " current " or " ke))]
        [else (if (and (string=? (transition-current (first lot)) current)
                       (key=? (transition-key (first lot)) ke))
                  (transition-next (first lot))
                  (find (rest lot) current ke))]))


;; launch program
;(fsm-simulate fsm-s)

