;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex527-circle-pt) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; constants
(define CENTER (make-posn 200 200))
(define RADIUS 50) ; the radius in pixels 


;; data examples
(define c-1 (circle 50 "outline" "black"))
(define MT (empty-scene 400 400))


;; functions
; Number -> Posn
; determines the point on the circle with CENTER 
; and RADIUS whose angle is 
 
; examples
; what are the x and y coordinates of the desired 
; point, when given: 120/360, 240/360, 360/360

(check-within (circle-pt 120/360)
              (make-posn #i225.0 #i243.30127018922192)
              0.1)

(define (circle-pt factor)
  (local ((define x (+ (posn-x CENTER)
                       (* RADIUS (cos (* pi factor)))))
          (define y (+ (posn-y CENTER)
                       (* RADIUS (sin (* pi factor))))))
    (make-posn x y)))


;; test
; [List-of Number] -> Image
; add lines specific of circle-pt and CENTER to the scene with an circle,
; to test the output of circle-pt.

(define (test-circle-pt factors)
  (let* ([points (map circle-pt factors)]
         [point-pairs (map (λ (p) `(,(posn-x p) ,(posn-y p)))
                           points)]
         [s0 (place-images (list c-1)
                           (list CENTER)
                           MT)])
    (foldr (λ (line scene) (apply scene+line
                                  `(,scene ,@line "red")))
           s0
           (map (λ (p) `(,(posn-x CENTER)
                         ,(posn-y CENTER)
                         ,@p))
                point-pairs))))


(test-circle-pt '(480/360 240/360 720/360))
(test-circle-pt '(120/360 240/360 360/360))

