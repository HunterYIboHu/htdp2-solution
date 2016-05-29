;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname car-world) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 常量
; 程序的单一控制点
(define WHEEL-RADIUS 20)

; 每秒移动的像素由轮子的半径决定
(define SPEED (* (/ 3 5) WHEEL-RADIUS))

; 根据轮子的半径决定世界的大小，运行时间总是相近的。
; 此外，世界的比例固定为2:1
(define WIDTH-OF-WORLD (* WHEEL-RADIUS 40))
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 2))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD
                                HEIGHT-OF-WORLD))

; 车轮间距、车轮和车身等，遵循与车轮半径之间的关系。
(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle
               WHEEL-DISTANCE
               WHEEL-RADIUS
               "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define CAR-BODY
  (rectangle (* WHEEL-DISTANCE 5)
             (* WHEEL-RADIUS 3)
             "solid" "red"))
(define CAR-TOP
  (rectangle (* WHEEL-DISTANCE 3)
             (* WHEEL-RADIUS 2)
             "solid" "red"))
(define CAR-MAIN
  (overlay/xy BOTH-WHEELS
              (- 0 WHEEL-DISTANCE)
              (- 0 WHEEL-DISTANCE)
              CAR-BODY))
(define CAR
  (overlay/xy CAR-TOP
              (- WHEEL-DISTANCE)
              WHEEL-RADIUS
              CAR-MAIN))

; 只使用一次，辅助车子离开世界。
(define HALF-WIDTH-OF-CAR
  (/ (image-width CAR) 2))

(define CAR-H
  (image-height CAR))


; WorldState is a Number
; interpretation the number of pixels between the left border and
; the car

; WorldState -> Image
; places the image of the car x pixels from the left margin of
; the BACKGROUND image
(define (render x)
  (place-image CAR
               x (+ (- HEIGHT-OF-WORLD
                    CAR-H) (* 2 WHEEL-RADIUS))
               BACKGROUND))


; WorldState -> WorldState
; adds Speed to x to move the car right
(define (tock x)
  (+ x SPEED))


; key-stroke-handler


; mouse-event-handler


; end?
(define (get-to-end? x)
  (if (>= x (+ WIDTH-OF-WORLD
               HALF-WIDTH-OF-CAR))
      #t
      #f))


; WorldState -> WorldState
; launched the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [stop-when get-to-end?]))


(main 13)

