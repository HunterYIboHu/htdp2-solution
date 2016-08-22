;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex165-substitute) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define OLD "robot")
(define NEW "r2d2")


;; data difinition
; List-of-strings is one of:
; - '()
; - (cons String List-of-strings)

(define TOY-THREE (cons "robot-Land is not a robot company"
                        (cons "Apply, a really wonderful robot promised land"
                              (cons "The best robot company is Windows"
                                    '()))))
(define TOY-NONE (make-list 10 "nothing"))


;; main-functions
; List-of-strings -> List-of-strings
; replace all occurrences of "robot" with "r2d2"

(check-expect (subst-robot TOY-THREE) (cons "r2d2-Land is not a r2d2 company"
                                            (cons "Apply, a really wonderful r2d2 promised land"
                                                  (cons "The best r2d2 company is Windows" '()))))
(check-expect (subst-robot TOY-NONE) TOY-NONE)
(check-expect (subst-robot '()) '())

(define (subst-robot alos)
  (cond [(empty? alos) '()]
        [(cons? alos) (cons (convert (first alos))
                            (subst-robot (rest alos)))]))


; List-of-strings -> List-of-strings
; convert the given word old and replace it with new in the string
; on the given list alos.

(check-expect (substitute TOY-THREE "robot" "r2d2") (cons "r2d2-Land is not a r2d2 company"
                                                          (cons "Apply, a really wonderful r2d2 promised land"
                                                                (cons "The best r2d2 company is Windows" '()))))
(check-expect (substitute TOY-NONE "robot" "r2d2") TOY-NONE)

(define (substitute alos old new)
  (cond [(empty? alos) '()]
        [(cons? alos) (cons (convert-u (first alos) old new)
                            (substitute (rest alos) old new))]))


;; auxilliary functions
; String -> String
; replace all occurrences of "robot" with "r2d2" in the given string.

(check-expect (convert "robot") "r2d2")
(check-expect (convert "robot's company")
              "r2d2's company")
(check-expect (convert "robots' robot is the best robot")
              "r2d2s' r2d2 is the best r2d2")
(check-expect (convert "nothing") "nothing")
(check-expect (convert "no robot") "no r2d2")

(define (convert s)
  (cond [(string=? "" s) ""]
        [(string-contains? OLD s)
         (if (string=? OLD (substring s 0 (string-length OLD)))
             (string-append NEW (convert (if (> (string-length s) (string-length OLD))
                                                (substring s (string-length OLD))
                                                "")))
             (string-append (string-ith s 0) (convert (substring s 1))))]
        [else s]))


; String -> String
; replace all occurences of old word with new word in the given string.

(check-expect (convert-u "robot" "robot" "r2d2") "r2d2")
(check-expect (convert-u "NASA is the NASA of America." "NASA" "CERN") "CERN is the CERN of America.")
(check-expect (convert-u "中国是中国人的中国" "中国" "美国") "美国是美国人的美国")

(define (convert-u s old new)
  (cond [(string=? "" s) ""]
        [(string-contains? old s)
         (if (string=? old (substring s 0 (string-length old)))
             (string-append new (convert-u (if (> (string-length s) (string-length old))
                                               (substring s (string-length old))
                                               "")
                                           old new))
             (string-append (string-ith s 0) (convert-u (substring s 1) old new)))]
        [else s]))