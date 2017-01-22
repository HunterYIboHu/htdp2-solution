;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex382-bw-machine) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An XMachine is a nested list of this shape:
; `(machine ((intial ,FSM-State)) [List-of X1T])
; An X1T is a nested list of this shape:
; `(action ((state ,FSM-State) (next ,FSM-State)))
; A FSM-State is a String that specifies a color


(define x1t-1 '(action ((state "black") (next "white"))))
(define x1t-2 '(action ((state "white") (next "black"))))

(define BW-machine `(machine ((initial "black")) (,x1t-1 ,x1t-2)))


(define action-1 "<action state=\"black\" next=\"white\" />")
(define action-2 "<action state=\"white\" next=\"black\" />")
(define machine-1 (string-append "<machine initial=\"black\">\n"
                                 "\t" action-1 "\n"
                                 "\t" action-2 "\n"
                                 "</machine>\n"))