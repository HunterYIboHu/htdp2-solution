;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex207-total-time) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/itunes)

;; data difinitions

;(define-struct date [year month day hour minute second])
; A Date is a structure:
;    (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (1 ~ 12), day (1 ~ 31), hour (0 ~ 23),
; minute (0 ~ 59), andsecond (0 ~ 59)

(define 1-add (create-date 2016 8 12 14 20 50))
(define 1-play (create-date 2016 8 12 14 30 24))
(define 2-add (create-date 2016 7 29 22 15 45))
(define 2-play (create-date 2016 8 9 12 20 30))
(define 3-add (create-date 2016 7 14 20 13 45))
(define 3-play (create-date 2016 8 5 19 7 3))

;;;; data difinition functions ;;;;
; String -> List
; consume a n as the name of track

(define (create-name n)
  (list "name" n))


; String -> List
; consume a n as the name of artists

(define (create-artist n)
  (list "artist" n))


; String -> List
; consume a t as the title of album

(define (create-album t)
  (list "album" t))


; N -> List
; consume a N as the lasting time of music, by milesecond.

(define (create-time lt)
  (list "time" lt))


; N -> List
; consume a N as its postion with the album

(define (create-track# pos)
  (list "track#" pos))


; Date -> List
; the date represent when the track is added

(define (create-added d)
  (list "added" d))


; N -> List
; the number repersent how often it has been played

(define (create-play# pt)
  (list "play#" pt))


; Date -> List
; the date represent when the track is played recently

(define (create-played d)
  (list "played" d))


;;;; end difinition functions ;;;;
; An Association is a list of two items:
; (cons String (cons BSDN '()))

(define 1-name (create-name "Ascendance"))
(define 2-name (create-name "Master of Tides"))
(define 3-name (create-name "Animals"))

(define 1-artist (create-artist "Lindsey Stirling"))
(define 2-artist (create-artist "Maroon5"))

(define 1-album (create-album "Shatter Me"))
(define 2-album (create-album "Animals"))

(define 1-time (create-time 266000))
(define 2-time (create-time 261000))
(define 3-time (create-time 231000))

(define 1-track# (create-track# 8))
(define 2-track# (create-track# 11))
(define 3-track# (create-track# 1))

(define 1-added (create-added 1-add))
(define 2-added (create-added 2-add))
(define 3-added (create-added 3-add))

(define 1-play# (create-play# 45))
(define 2-play# (create-play# 60))
(define 3-play# (create-play# 100))

(define 1-played (create-played 1-play))
(define 2-played (create-played 2-play))
(define 3-played (create-played 3-play))

; A BSDN is one of:
; - Boolean
; - Number
; - String
; - Date

; An LAssoc is one of:
; - '()
; - (cons Association LAssoc)

(define 1-music (list 1-name 1-artist 1-album 1-time 1-track# 1-added 1-play# 1-played))
(define 2-music (list 2-name 1-artist 1-album 2-time 2-track# 2-added 2-play# 2-played))
(define 3-music (list 3-name 2-artist 2-album 3-time 3-track# 3-added 3-play# 3-played))


; An LLists is one of:
; - '()
; - (cons LAssoc LLists)

(define 1-Track (list 1-music 2-music 3-music))
(define 2-Track (list 2-music 1-music))
(define one-Track (make-list 10 1-music))
(define two-Track (list 2-music 2-music 3-music 2-music 3-music))

;; main functions
; LLists -> Number
; produces the total amount of play time

(check-expect (total-time/list 1-Track) 758000)
(check-expect (total-time/list 2-Track) 527000)
(check-expect (total-time/list '()) 0)

(define (total-time/list ll)
  (cond [(empty? ll) 0]
        [else (+ (second (assoc "time" (first ll)))
                 (total-time/list (rest ll)))]))

