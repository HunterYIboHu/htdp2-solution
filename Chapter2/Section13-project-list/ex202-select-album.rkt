;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex202-select-album) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; String LTracks -> LTracks
; extracts the specific Tracks as list by the given album name from the
; given lt.

(check-error (select-album "ALieZ" 1-Track))
(check-expect (select-album "ALieZ" '()) '())
(check-expect (select-album "Animals" 1-Track) (list 3-music))
(check-expect (select-album "Shatter Me" 2-Track) (list 2-music 1-music))

(define (select-album name lt)
  (cond [(empty? lt) '()]
        [(not (member? name (select-album-titles/unique lt)))
         (error (string-append "There are not any album named " name
                               " in the given LTracks"))]
        [else (if (string=? name (track-album (first lt)))
                  (cons (first lt)
                        (select-album name (rest lt)))
                  (select-album name (rest lt)))]))


;; auxiliary functions
; LTracks -> List-of-strings
; produces the list of album titles of the given lt.

(check-expect (select-all-album-title 1-Track)
              (list "Shatter Me" "Shatter Me" "Animals"))
(check-expect (select-all-album-title 2-Track)
              (list "Shatter Me" "Shatter Me"))
(check-expect (select-all-album-title '()) '())

(define (select-all-album-title lt)
  (cond [(empty? lt) '()]
        [else (cons (track-album (first lt))
                    (select-all-album-title (rest lt)))]))


; LTracks -> List-of-Strings
; produces a list of unique album titles on the given lt.

(check-expect (select-album-titles/unique one-Track) (list "Shatter Me"))
(check-expect (select-album-titles/unique two-Track)
              (list "Shatter Me" "Animals"))
(check-expect (select-album-titles/unique '()) '())

(define (select-album-titles/unique lt)
  (create-set (select-all-album-title lt)))


; List-of-strings -> List-of-strings
; produces a list of string which contains all member of the given one,
; but all string could only contains once.

(check-expect (create-set (make-list 2 "abc")) (list "abc"))
(check-expect (create-set (list "abc" "df" "abc" "df" "jack"))
              (list "abc" "df" "jack"))
(check-expect (create-set '()) '())

(define (create-set los)
  (cond [(empty? los) '()]
        [else (cons (first los)
                    (create-set (remove-all (first los) (rest los))))]))














