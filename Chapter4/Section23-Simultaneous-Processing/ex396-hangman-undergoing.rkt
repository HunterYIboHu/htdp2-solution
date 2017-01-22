;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex396-hangman-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)


;; data difinitions
; A HM-Word is a [List-of Letter or "_"]
; interpretation "_" represents a letter to be guessed


;; constants
(define LETTERS (explode "abcdefghijklmnopqrstuvwxyz_"))

(define LOCATION "C:\\Users\\HuYibo\\Application\\HtDP-for-git\\en_US.dic")
(define AS-LIST (read-lines LOCATION))
(define SIZE (length AS-LIST))

(define CAT (explode "cat"))
(define DISTRIBUTE (explode "distribute"))


;; functions
; HM-Word N -> String
; run a simplistic Hangman game, produce the current state
(define (play the-pick time-limit)
  (local ((define the-word  (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          ; HM-Word -> HM-Word
          (define (do-nothing s) s)
          ; HM-Word KeyEvent -> HM-Word 
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status))
          ; HM-Word -> Boolean
          (define (word-guessed? current-status)
            (equal? the-word current-status))
          ; HW-Word -> Image
          (define (render-final w)
            (above (text/font (implode w) 22 "black" "consolas"
                              'modern 'normal 'normal #f)
                   (text/font (implode the-word) 22 "red" "consolas"
                              'modern 'normal 'normal #f)))
          )
    (implode
     (big-bang the-guess ; HM-Word
       [to-draw render-word]
       [on-tick do-nothing 1 time-limit]
       [on-key  checked-compare]
       [stop-when word-guessed? render-final]))))


; HM-Word -> Image
; render the current state to the image.

(check-expect (render-word CAT)
              (above (text/font "cat" 22 "black" "consolas"
                                'modern 'normal 'normal #f)
                     (text/font "final answer" 22 "red" "consolas"
                                'modern 'normal 'normal #f)))
(check-expect (render-word DISTRIBUTE)
              (above (text/font "distribute" 22 "black" "consolas"
                                'modern 'normal 'normal #f)
                     (text/font "final answer" 22 "red" "consolas"
                                'modern 'normal 'normal #f)))

(define (render-word w)
  (above (text/font (implode w) 22 "black" "consolas" 'modern 'normal 'normal #f)
         (text/font "final answer" 22 "red" "consolas"
                    'modern 'normal 'normal #f)))


; HW-Word HW-Word KeyEvent -> HW-Word
; produces the word which the player guessed.

(check-expect (compare-word CAT (explode "___") "c") (explode "c__"))
(check-expect (compare-word CAT (explode "___") "d") (explode "___"))
(check-expect (compare-word CAT (explode "_a_") "a") (explode "_a_"))
(check-expect (compare-word DISTRIBUTE (explode "d_________") "i")
              (explode "di___i____"))

(define (compare-word the-word current ke)
  (cond [(empty? the-word) '()]
        [else (cons (if (string=? ke (first the-word))
                        ke
                        (first current))
                    (compare-word (rest the-word) (rest current) ke))]))


;; launch program
(play (list-ref AS-LIST (random SIZE)) 30)