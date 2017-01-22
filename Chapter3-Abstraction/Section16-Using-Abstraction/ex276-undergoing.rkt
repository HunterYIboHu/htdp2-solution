;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex276-undergoing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
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

;(define-struct track
;  [name artist album time track# added play# played])
; A Track is a structure:
;    (make-track String Strign String N N Date N Date)
; interpretation An instance records in order: the track's title, its
; producing artist, to which album it belongs, its playing time in millisecond
; its position with the album, the date it was added, how often it has been
; played, and the date when it was last played.

(define 1-music (create-track "Ascendance" "Lindsey Stirling" "Shatter Me"
                            266000 8 1-add 45 1-play))
(define 2-music (create-track "Master of Tides" "Lindsey Stirling" "Shatter Me"
                            261000 11 2-add 60 2-play))
(define 3-music (create-track "Animals" "Maroon5" "Animals"
                            231000 1 3-add 100 3-play))

; An LTracks is one of:
; - '()
; - (cons Track LTracks)

(define 1-Track (list 1-music 2-music 3-music))
(define 2-Track (list 2-music 1-music))
(define one-Track (make-list 10 1-music))
(define two-Track (list 2-music 2-music 3-music 2-music 3-music))


;; main functions
; String Date LTracks -> LTracks
; produces a LTracks contains the tracks which played after the given date
; according to the given toa (title of album), the recently played date and
; a LTrack lt. 

(check-expect (select-album-date "Shatter Me" 3-play 1-Track)
              (list 1-music 2-music))
(check-expect (select-album-date "Shatter Me" 2-play 1-Track)
              (list 1-music))
(check-expect (select-album-date "Animals" 3-play 1-Track) '())
(check-expect
 (select-album-date "Animals" (create-date 2000 1 1 12 12 12) 1-Track)
 (list 3-music))
(check-expect (select-album-date "Another" 3-play 1-Track) '())

(define (select-album-date album date tracks)
  (local (; String Track -> Boolean
          ; determine whether the given track belongs to the given title of
          ; album.
          (define (belong-to-album? t)
            (string=? (track-album t) album))
          ; Track -> Boolean
          ; determine whether the given track satisfied the condition:
          ; 1. belong to the given album
          ; 2. played after the given date
          (define (satisfy? t)
            (and (belong-to-album? t)
                 (played-after? date t))))
    (filter satisfy? tracks)))


; LTracks -> [List-of LTracks]
; consumes a lt and produce a list of LOT, per album one list.

(check-expect (select-albums 1-Track)
              (list (list 1-music 2-music) (list 3-music)))
(check-expect (select-albums 2-Track)
              (list (list 2-music 1-music)))

(define (select-albums lot)
  (local ((define albums (create-set (map (lambda (x) (track-album x)) lot)))
          ; String -> LTrack
          ; consume a album's title and produces another lt which contains the same album.
          (define (select-album a)
            (filter (lambda (x) (string=? (track-album x) a)) lot)))
    (map select-album albums)))


;; auxiliary function
; Date Track -> Boolean
; compare the given two date and return #true if the first one is early (not equal or late) than the second one.

(check-expect (played-after? 1-play 2-music) #false)
(check-expect (played-after? 1-play 1-music) #false)
(check-expect (played-after? 2-play 1-music) #true)

(define (played-after? d t)
  (local ((define cmp-function `(,date-year ,date-month ,date-day ,date-hour ,date-minute ,date-second))
          (define played-date (track-played t))
          (define result (map (lambda (x) `(,(< (x d) (x played-date))
                                            ,(> (x d) (x played-date)))) cmp-function))
          ; [List-of [List-of Boolean]] -> Boolean
          ; compare the reuslt and produces the cmp-result.
          (define (cmp-result lob)
            (cond [(empty? lob) #false]
                  [else (local ((define current-result (first lob)))
                          (cond [(and (boolean=? #false (first current-result))
                                      (boolean=? #false (second current-result)))
                                 (cmp-result (rest lob))]
                                [(boolean=? #true (first current-result)) #true]
                                [else #false]))])))
    (cmp-result result)))


; [List-of X] -> [List-of X]
; produces the list whose item don't same as each other, like set.

(check-expect (create-set '(1 2 3 4 5 6 5 3 2 1)) '(1 2 3 4 5 6))
(check-expect (create-set '()) '())
(check-expect (create-set '("String" "String" "set")) '("String" "set"))

(define (create-set l)
  (cond [(empty? l) '()]
        [else (local ((define current (first l)))
                (cons current (create-set (filter (lambda (x) (not (equal? x current))) l))))]))








