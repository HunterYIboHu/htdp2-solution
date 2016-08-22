;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex203-select-album-date) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define (select-album-date toa date lt)
  (cond [(empty? lt) '()]
        [else (if (and (string=? toa (track-album (first lt)))
                       (early? date (track-played (first lt))))
                  (cons (first lt)
                        (select-album-date toa date (rest lt)))
                  (select-album-date toa date (rest lt)))]))


;; auxiliary functions
; Date Date -> Boolean
; compare the given two date and return #true if the first one is early (not equal or late) than the second one.

(check-expect (early? 1-play 2-play) #false)
(check-expect (early? 1-play 1-play) #false)
(check-expect (early? 2-play 1-play) #true)

(define (early? d1 d2)
  (cond [(< (date-year d1) (date-year d2)) #t]
        [(> (date-year d1) (date-year d2)) #f]
        [else (cond [(< (date-month d1) (date-month d2)) #t]
                    [(> (date-month d1) (date-month d2)) #f]
                    [else (cond [(< (date-day d1) (date-day d2)) #t]
                                [(> (date-day d1) (date-day d2)) #f]
                                [else (cond [(< (date-hour d1) (date-hour d2)) #t]
                                            [(> (date-hour d1) (date-hour d2)) #f]
                                            [else (cond [(< (date-minute d1) (date-minute d2)) #t]
                                                        [(> (date-minute d1) (date-minute d2)) #f]
                                                        [else (cond [(< (date-second d1) (date-second d2)) #t]
                                                                    [(>= (date-second d1) (date-second d2)) #f])])])])])]))


