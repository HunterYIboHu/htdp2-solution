;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex111-key-FSM) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; graphic constants
(define WIDTH 200)
(define HEIGHT 100)
(define MID-W (/ WIDTH 2))
(define MID-H (/ HEIGHT 2))
(define FONT-POS 20)
(define INITIAL "white")
(define INPUT "yellow")
(define FINISHED "green")
(define ERROR "red")
(define FONT-SIZE 12)
(define FONT-COLOR "black")
(define FONT-COLOR-2 "blue")


; String -> Image
; render the scene Image by the color given by String
; examples:
(check-expect (bkg INITIAL)
              (empty-scene WIDTH HEIGHT INITIAL))
(check-expect (bkg ERROR)
              (empty-scene WIDTH HEIGHT ERROR))

(define (bkg color)
  (empty-scene WIDTH HEIGHT color))


; ExpectsToSee is one of:
; - AA
; - BC
; - DD
; - ER

(define AA "start, expect to see an 'a' next")
(define BC "expect to see: 'b', 'c' or 'd'")
(define DD "encountered a 'd', finished")
(define ER "error, user pressed illegal key")


(define-struct gs [expect color content])
; GameState is (make-gs e cl ct)
; e is short for ExpectToSee
; cl is short for color, one of 4:
; - INITIAL
; - INPUT
; - FINISED
; - ERROR
; ct is short for text content, the already input key.
; examples:
(define gs-s (make-gs AA INITIAL ""))
(define gs-i (make-gs BC INPUT "a"))
(define gs-b (make-gs BC INPUT "abbbbbc"))
(define gs-d (make-gs DD FINISHED "abcd"))
(define gs-e1 (make-gs ER ERROR "ae"))


; KeyEvent is one of:
; - 'a'
; - 'b'
; - 'c'
; - 'd'
; - other


(define (key-game gs)
  (big-bang gs
            [on-key press-key]
            [to-draw render]
            [stop-when end?]))


; GameState -> Image
; show the string on the center of scene, and set the color of
; background.
; examples:
(check-expect (render gs-s)
              (render/expect (gs-expect gs-s)
                             (render/text (gs-content gs-s)
                                          (bkg (gs-color gs-s)))))
(check-expect (render gs-i)
              (render/expect (gs-expect gs-i)
                             (render/text (gs-content gs-i)
                                          (bkg (gs-color gs-i)))))


(define (render gs)
  (render/expect (gs-expect gs)
                  (render/text (gs-content gs)
                               (bkg (gs-color gs)))))


; ExpectToSee -> Image
; render the ExpectToSee in the head of the scene
; examples:
(check-expect (render/expect AA (bkg INITIAL))
              (place-image (text AA FONT-SIZE FONT-COLOR-2)
                           MID-W FONT-POS (bkg INITIAL)))
(check-expect (render/expect DD (bkg FINISHED))
              (place-image (text DD FONT-SIZE FONT-COLOR-2)
                           MID-W FONT-POS (bkg FINISHED)))

(define (render/expect ets img)
  (place-image (text ets FONT-SIZE FONT-COLOR-2)
               MID-W FONT-POS img))


; String -> Image
; render the text in the middle of scene
; examples:
(check-expect (render/text "" (bkg INITIAL))
              (place-image (text "" FONT-SIZE FONT-COLOR)
                           MID-W MID-H (bkg INITIAL)))
(check-expect (render/text "abcc" (bkg INPUT))
              (place-image (text "abcc" FONT-SIZE FONT-COLOR)
                           MID-W MID-H (bkg INPUT)))

(define (render/text str img)
  (place-image (text str FONT-SIZE FONT-COLOR)
               MID-W MID-H img))


; GameState KeyEvent -> GameState
; change the content of GameState determined by the KeyEvent.
; when ke is "a" and color is INITIAL, set color to INPUT,
; update the content and set expect to BC;
; when ke is "b" or "c" and color is INPUT, update the content
; and return it;
; when ke is "d" and color is INPUT, set color to FINISHED,
; update the content and set expect to DD;
; other case the color will be set to ERROR
(check-expect (press-key gs-s "a")
              (make-gs BC INPUT "a"))
(check-expect (press-key gs-s "c")
              (make-gs ER ERROR "c"))
(check-expect (press-key gs-i "c")
              (make-gs BC INPUT "ac"))
(check-expect (press-key gs-i "b")
              (make-gs BC INPUT "ab"))
(check-expect (press-key gs-b "d")
              (make-gs DD FINISHED "abbbbbcd"))

(define (press-key gs ke)
  (cond [(and (string=? ke "a")
              (string=? (gs-color gs) INITIAL))
         (make-gs BC
                  INPUT
                  (string-append (gs-content gs) ke))]
        [(and (or (string=? ke "b")
                  (string=? ke "c"))
              (string=? (gs-color gs) INPUT))
         (make-gs BC
                  INPUT
                  (string-append (gs-content gs) ke))]
        [(and (string=? ke "d")
              (string=? (gs-color gs) INPUT))
         (make-gs DD
                  FINISHED
                  (string-append (gs-content gs) ke))]
        [else (make-gs ER
                       ERROR
                       (string-append (gs-content gs) ke))]))


; GameState -> Boolean
; determine weather to end the game.
; if color is FINISHED, return #t
; if color is ERROR, return #t
; else return #f
(check-expect (end? gs-s) #false)
(check-expect (end? gs-d) #true)
(check-expect (end? gs-e1) #true)

(define (end? gs)
  (if (or (string=? (gs-color gs) FINISHED)
          (string=? (gs-color gs) ERROR))
      #true
      #false))


(key-game gs-s)
































