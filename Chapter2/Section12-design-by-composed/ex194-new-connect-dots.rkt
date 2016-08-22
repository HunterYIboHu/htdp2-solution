;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex194-new-connect-dots) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; data difinitions
; A Polygon is one of:
; - (list Posn Posn Posn)
; - (cons Posn Polygon)

(define triangle-p (list (make-posn 20 10)
                         (make-posn 20 20)
                         (make-posn 30 20)))
(define square-p (list (make-posn 10 10)
                       (make-posn 20 10)
                       (make-posn 20 20)
                       (make-posn 10 20)))


; A NELop is one of:
; - (cons Posn '())
; - (cons Posn NELop)


;; constants
; a plain background image
(define MT (empty-scene 50 50))


;; main functions
; Image Polygon -> Image
; renders the given polygon p into img

(check-expect (render-poly MT triangle-p)
              (scene+line (scene+line (scene+line MT 20 10 20 20 "red")
                                      20 20 30 20 "red")
                          30 20 20 10 "red"))
(check-expect (render-poly MT square-p)
              (scene+line (scene+line (scene+line (scene+line MT
                                                              10 10 20 10 "red")
                                                  20 10 20 20 "red")
                                      20 20 10 20 "red")
                          10 20 10 10 "red"))

(define (render-poly img p)
  (connect-dots img p (first p)))


;; auxiliary functions
; Image Posn -> Posn
; draws a red line from Posn p to Posn q into im

(check-expect (render-line MT (make-posn 10 20) (make-posn 20 10))
              (scene+line MT 10 20 20 10 "red"))

(define (render-line img p q)
  (scene+line img (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))


; Image NELop Posn -> Image
; connects the dots in p by rendering lines in img, and connects
; the last dot with the additional ap.

(check-expect (connect-dots MT triangle-p (make-posn 20 10))
              (scene+line (scene+line (scene+line MT 20 10 20 20 "red")
                                      20 20 30 20 "red")
                          30 20 20 10 "red"))
(check-expect (connect-dots MT square-p (make-posn 10 10))
              (scene+line (scene+line (scene+line (scene+line MT
                                                              10 10 20 10 "red")
                                                  20 10 20 20 "red")
                                      20 20 10 20 "red")
                          10 20 10 10 "red"))

(define (connect-dots img p ap)
  (cond [(empty? (rest p)) (render-line img (first p) ap)]
        [else (render-line (connect-dots img (rest p) ap)
                           (first p)
                           (second p))]))

