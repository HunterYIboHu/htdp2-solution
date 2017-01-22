;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex383-BW-machine-real) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;(require 2htdp/batch-io)
;(require 2htdp/image)
;(require 2htdp/universe)


;; data difinitions
; An XMachine is a nested list of this shape:
; `(machine ((intial ,FSM-State)) [List-of X1T])
; An X1T is a nested list of this shape:
; `(action ((state ,FSM-State) (next ,FSM-State)))
; A FSM-State is a String that specifies a color

; A FSM is a [List-of 1Transition]
; A 1Transition is a list of two items:
;    (list FSM-State FSM-State)
; A FSM-State is a String that specifies a color


;; constants
(define path-to-xml "C:\\Users\\HuYibo\\Application\\HtDP-for-git\\Chapter4\\Section22-the-commerce-of-XML")
(define BW-xexpr (read-plain-xexpr (string-append path-to-xml "\\fsm-BW.xml")))
;; the xexpr's item's order can't be predicated.(Acturally could, it's ordered by the alphebeta)

(define a0 '((initial "X")))
(define a1 '((initial "X") (exact "true") (support-1.1 "true")))
(define a2 '((exact "true") (racket-version "6.5[3m]")))

(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

(define x1t-1 '(action ((state "black") (next "white"))))
(define x1t-2 '(action ((state "white") (next "black"))))

(define xm0
  '(machine ((initial "red"))
     (action ((state "red") (next "green")))
     (action ((state "green") (next "yellow")))
     (action ((state "yellow") (next "red")))))
(define BW-machine `(machine ((initial "black"))
                             ,x1t-1
                             ,x1t-2))

(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))
(define fsm-BW
  '(("black" "white") ("white" "black")))


;; functions
; XMachine -> FSM-State
; simulates an FSM via the given configuration
(define (simulate-xmachine xm)
  (simulate (xm-state0 xm)
            (xm->transitions xm)))


; XMachine -> FSM-State
; extracts and translates the transition table from xm0

(check-expect (xm-state0 xm0) "red")
(check-expect (xm-state0 BW-machine) "black")

(define (xm-state0 xm)
  (second (find-attr (xexpr-attr xm) 'initial)))


; XMachine -> [List-of !Transition]
; extracts the transition table from xm

(check-expect (xm->transitions xm0) fsm-traffic)
(check-expect (xm->transitions BW-machine) fsm-BW)

(define (xm->transitions xm)
  (local (; X1T -> 1Transition
          (define (xaction->action xa)
            (list (second (find-attr (xexpr-attr xa) 'state))
                  (second (find-attr (xexpr-attr xa) 'next)))))
    (map xaction->action (xexpr-content xm))))


;; auxiliary functions
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


; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the content of the given xe by list of xexpr.

(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '((action)))
(check-expect (xexpr-content e3) '((action)))
(check-expect (xexpr-content e4) '((action) (action)))

(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond [(empty? optional-loa+content) '()]
          [else (local ((define c-or-loa (first optional-loa+content)))
                  (if (list-of-attributes? c-or-loa)
                      (rest optional-loa+content)
                      optional-loa+content))])))


; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe.

(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) a0)
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) a0)

(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond [(empty? optional-loa+content) '()]
          [else (local ((define loa-or-x (first optional-loa+content)))
                     (if (list-of-attributes? loa-or-x)
                         loa-or-x
                         '()))])))


; [List-of Attribute] or Xexpr.v2 -> Boolean
; determine whether x is an element of [List-of Attribute]
; #false otherwise

(check-expect (list-of-attributes? a0) #true)
(check-expect (list-of-attributes? '()) #true)
(check-expect (list-of-attributes? '(action)) #false)

(define (list-of-attributes? x)
  (cond [(empty? x) #true]
        [else (local ((define possible-attribute (first x)))
                (cons? possible-attribute))]))


; [List-of Attribute] Symbol -> [Maybe String]
; produces the pair which starts with the given attr in the la;
; #false otherwise.

(check-expect (find-attr a0 'initial) '(initial "X"))
(check-expect (find-attr a1 'support-1.1) '(support-1.1 "true"))
(check-expect (find-attr a2 'initial) #false)

(define (find-attr al attr)
  (assq attr al))


;; launch program
(simulate-xmachine BW-xexpr)