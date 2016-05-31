;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.5-rocket-launch) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; physical constants
(define HEIGHT 300)
(define WIDTH (/ HEIGHT 3))
(define YDELTA 3)

; graphical constants
(define BACKG (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))
(define X-ROCKET 10)


; A LRCD (short for: launching rocket count down) is one of:
; - "resting"
; - a number in [-3, -1]
; - a non-negative number
; interpretation a rocket resting on the ground, in count-down
; mode, or the number of pixels from the top i.e. its height


; Number -> Image
; a auxiliary function traslate Number to Image that
; shows part of function show.
(define (show/auxi num)
  (place-image ROCKET
               X-ROCKET (- num ROCKET-CENTER)
               BACKG))


; LRCD -> Image
; renders the state as a resting or flying rocket

(check-expect
 (show "resting") (show/auxi HEIGHT))
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              X-ROCKET (* 3/4 WIDTH)
              (show/auxi HEIGHT)))
(check-expect
 (show 53) (show/auxi 53))
(check-expect
 (show 0) (show/auxi 0))

(define (show x)
  (cond
    [(cond [(string? x) (string=? x "resting")]
           [else #f])
     ; 这里检查x的类型，因为字符串类型只有一个，而如果只是检查其
     ; 是否为字符串"resting"，则会在x是数字的时候报错，非返回假值
     (show/auxi HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  X-ROCKET (* 3/4 WIDTH)
                  (show/auxi HEIGHT))]
    [(>= x 0) (show/auxi x)]))

; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed
; if the rocket is still resting

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))


; LRCD -> LRCD
(define (main1 s)
  (big-bang s
            [to-draw show]
            [on-key launch]))


(main1 "resting")


; LRCD ->LRCD
; raises the rocket by YDELTA
; if it is moving already

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; ex58 ALL THE REST
; LRCD -> Boolean
; when LRCD = YDELTA, return true; else return false.
(define (end? x)
  (if (number? x) (= x YDELTA) #f))


; LRCD -> LRCD
(define (main2 s)
  (big-bang s
            [to-draw show]
            [on-key launch]
            [on-tick fly 0.1]
            [stop-when end?]))


(main2 "resting")