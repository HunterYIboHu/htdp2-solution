;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname car-world-test) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; ex43
; 常量
; 程序的单一控制点
(define WHEEL-RADIUS 5)

; 每秒移动的像素由轮子的半径决定
(define SPEED (* (/ 3 5) WHEEL-RADIUS))

(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

; 根据轮子的半径决定世界的大小，运行时间总是相近的。
; 此外，世界的比例固定为2:1
(define WIDTH-OF-WORLD (* WHEEL-RADIUS 40))
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 2))
(define BACKGROUND-PART-1 (empty-scene WIDTH-OF-WORLD
                                HEIGHT-OF-WORLD))
(define BACKGROUND
  (overlay/xy tree
              (- 0 (/ WIDTH-OF-WORLD 2))
              (- (image-height tree) HEIGHT-OF-WORLD)
              BACKGROUND-PART-1))

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

(define Y-CAR
  (+ (- HEIGHT-OF-WORLD
        CAR-H)
     (* 2 WHEEL-RADIUS)))


; WorldState is a Number
; interpretation the number of pixels between the left border and
; the car

; WorldState -> Image
; places the image of the car's right most edge ws pixels from
; the left margin of the BACKGROUND image
(define (render ws)
  (place-image CAR
               ws Y-CAR
               BACKGROUND))


; ex42
; WorldState -> WorldState
; moves the car by 3 pixels every time the clock ticks
; example:
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(define (tock x)
  (+ x 3))


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