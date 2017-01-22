;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex476-fsm-match) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; data definitions
(define-struct transition [current key next])
(define-struct fsm [initial transitions final])

; A FSM is a structure:
;   (make-fsm FSM-State [List-of 1Transition] FSM-State)
; A 1Transition is a structure:
;   (make-transition FSM-State 1String FSM-State)
; A FSM-State is String.


;; data examples:
; ExpectsToSee is one of:
; - AA
; - BC
; - DD
; - ER

(define AA "start, expect to see an 'a' next")
(define BC "expect to see: 'b', 'c' or 'd'")
(define DD "encountered a 'd', finished")
(define ER "error, user pressed illegal key")

(define AA-t (make-transition "AA" "a" "BC"))
(define BC-tb (make-transition "BC" "b" "BC"))
(define BC-tc (make-transition "BC" "c" "BC"))
(define DD-t (make-transition "BC" "d" "DD"))

(define fsm-a-bc*-d
  (make-fsm
   "AA"
   (list (make-transition "AA" "a" "BC")
         (make-transition "BC" "b" "BC")
         (make-transition "BC" "c" "BC")
         (make-transition "BC" "d" "DD"))
   "DD"))

(define match-1 "abcd")
(define match-2 "acbd")
(define match-3 "ad")
(define dis-1 "da")
(define dis-2 "aa")
(define dis-3 "d")


;; functions
; FSM String -> Boolean
; does a-fsm recognize the given string

(check-expect (fsm-match? fsm-a-bc*-d match-1) #t)
(check-expect (fsm-match? fsm-a-bc*-d match-2) #t)
(check-expect (fsm-match? fsm-a-bc*-d match-3) #t)
(check-expect (fsm-match? fsm-a-bc*-d "") #f)
(check-expect (fsm-match? fsm-a-bc*-d dis-1) #f)
(check-expect (fsm-match? fsm-a-bc*-d dis-2) #f)
(check-expect (fsm-match? fsm-a-bc*-d dis-3) #f)

(define (fsm-match? a-fsm a-string)
  (cond [(string=? a-string "") #false]
        [(false? (get-transition a-fsm
                                 (fsm-initial a-fsm)
                                 (string-first a-string)))
         #false]
        [else (local ((define current-t
                        (get-transition a-fsm
                                        (fsm-initial a-fsm)
                                        (string-first a-string)))
                      (define next-t (transition-next current-t)))
                (fsm-match/auxi a-fsm
                                next-t
                                (string-rest a-string)))]))

; FSM String -> Boolean
; does a-fsm recognize the given string

(check-expect (fsm-match-v2 fsm-a-bc*-d match-1) #t)
(check-expect (fsm-match-v2 fsm-a-bc*-d match-2) #t)
(check-expect (fsm-match-v2 fsm-a-bc*-d match-3) #t)
(check-expect (fsm-match-v2 fsm-a-bc*-d "") #f)
(check-expect (fsm-match-v2 fsm-a-bc*-d dis-1) #f)
(check-expect (fsm-match-v2 fsm-a-bc*-d dis-2) #f)
(check-expect (fsm-match-v2 fsm-a-bc*-d dis-3) #f)

(define (fsm-match-v2 a-fsm a-string)
  (local ((define final-state (fsm-final a-fsm))
          (define transitions (fsm-transitions a-fsm))
          ; String 1String -> [Maybe String]
          ; produces the next field of transition whose
          ; current field is current, and key field is ke;
          ; otherwise produces #false.
          (define (find-next-transition current ke)
            (local ((define maybe-result
                      (filter (lambda (t) (and (string=? (transition-current t) current)
                                               (string=? (transition-key t) ke)))
                              transitions)))
              (if (empty? maybe-result)
                  #false
                  (transition-next (first maybe-result)))))

          ; String [List-of 1String] -> Boolean
          ; determien whether los can lead to the final-state of a-fsm
          (define (end? current los)
            (cond [(empty? los) #false]                  
                  [else (local ((define maybe-next
                                  (find-next-transition current (first los)))
                                (define tail (rest los)))
                          (if (string? maybe-next)
                              (if (and (empty? tail)
                                       (string=? final-state maybe-next))
                                  #true
                                  (end? maybe-next tail))
                              #false))])))
    (end? (fsm-initial a-fsm) (explode a-string))))


;; auxiliary functions
; FSM 1String -> [Maybe 1Transition]
; produces the matching transition of a-fsm's transitions
; whose key equals the given ke, the state is the next state.

(check-expect (get-transition fsm-a-bc*-d "AA" "a")
              AA-t)
(check-expect (get-transition fsm-a-bc*-d "BC" "b")
              BC-tb)
(check-expect (get-transition fsm-a-bc*-d "BC" "c")
              BC-tc)
(check-expect (get-transition fsm-a-bc*-d "BC" "d")
              DD-t)
(check-expect (get-transition fsm-a-bc*-d "AA" "b")
              #false)

(define (get-transition a-fsm state ke)
  (local ((define maybe-result
            (filter (lambda (t)
                      (and (string=? ke (transition-key t))
                           (string=? state (transition-current t))))
                    (fsm-transitions a-fsm))))
    (if (empty? maybe-result)
        #false
        (first maybe-result))))


; FSM String String -> Boolean
; does the given string match the a-fsm.

(check-expect (fsm-match/auxi fsm-a-bc*-d "BC" "") #f)
(check-expect (fsm-match/auxi fsm-a-bc*-d "BC" "d") #t)
(check-expect (fsm-match/auxi fsm-a-bc*-d "BC" "c") #f)
(check-expect (fsm-match/auxi fsm-a-bc*-d "BC" "bcbc") #f)
(check-expect (fsm-match/auxi fsm-a-bc*-d "BC" "bcbcd") #t)

(define (fsm-match/auxi a-fsm current a-string)
  (cond [(string-empty? a-string) #false]
        [else (local ((define current-t
                        (get-transition a-fsm
                                        current
                                        (string-first a-string))))
                (if (transition? current-t)
                    (if (and (string-empty? (string-rest a-string))
                             (string=? (fsm-final a-fsm)
                                       (transition-next current-t)))
                        #true
                        (fsm-match/auxi a-fsm
                                        (transition-next current-t)
                                        (string-rest a-string)))
                    #false))]))


;; lib functions for string
; String -> String
; produces the first 1String of s.

(check-expect (string-first "abc") "a")
(check-expect (string-first "bc") "b")

(define (string-first s)
  (substring s 0 1))


; String -> Boolean
; determine whether s is empty-string.

(check-expect (string-empty? "") #t)
(check-expect (string-empty? "av") #f)

(define (string-empty? s)
  (string=? "" s))


; String -> String
; produces the rest 1String of s.

(check-expect (string-rest "abc") "bc")
(check-expect (string-rest "a") "")

(define (string-rest s)
  (substring s 1))

