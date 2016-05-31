;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Fig15-UFO-descending) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; WorldState is a Number
; interpretation height of UFO (from top)

; constants:
(define WIDTH 300)
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define X-STATUS 25)
(define Y-STATUS 10)

; A WorldState falls into one of three intervals:
; - between 0 and CLOSE
; - between CLOSE and HEIGHT
; - below HEIGHT


; visual constants:
(define MT (empty-scene WIDTH HEIGHT))
(define UFO
  (overlay (circle 10 "solid" "green")
           (rectangle 40 2 "solid" "green")))


; WorldState -> WorldState
(define (main y0)
  (big-bang y0
            [on-tick nxt]
            [to-draw render/status]))


; WorldState -> WorldState
; computes next location of UFO


(check-expect (nxt 11) 14)

(define (nxt y)
  (+ y 3))


; WorldState -> Image
; place UFO at given height into the center of MT

(check-expect
 (render 11) (place-image UFO (/ WIDTH 2) 11 MT))

(define (render y)
  (place-image UFO (/ WIDTH 2) y MT))


; WorldState -> Image
; adds a status line to the scene created by render

(check-expect (render/status 10)
              (place-image (text "descending" 11 "green")
                           X-STATUS Y-STATUS
                           (render 10)))

(define (render/status y)
  (place-image (cond
                 [(<= 0 y CLOSE)
                  (text "descending" 11 "green")]
                 [(and (< CLOSE y) (<= y HEIGHT))
                  (text "closing in" 11 "orange")]
                 [(> y HEIGHT)
                  (text "landed" 11 "red")])
               X-STATUS Y-STATUS
               (render y)))


(main 0)
















