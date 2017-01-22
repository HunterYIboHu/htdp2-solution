;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex529-make-curve) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; constants
(define SMALL 4)
(define MT (empty-scene 400 400))
(define COLOR "black")


;; data examples
(define point-A (make-posn 100 100))
(define point-C (make-posn 200 200))
(define point-B (make-posn 200 100))
(define point-B-1 (make-posn 100 300))


;; functions
; Posn Posn Posn -> [List-of Posn]
; produces a smooth curve connect two point A and C,
; and B represents the observer point.

(define (make-curve A C B)
  (cond [(too-small? A C B) '()]
        [else (let* (; Posn Posn -> Posn
                     ; produces the mid point of the given two points.
                     [mid-point
                      (λ (front end)
                        (make-posn (/ (foldr + 0 (map posn-x `(,front ,end))) 2)
                                   (/ (foldr + 0 (map posn-y `(,front ,end))) 2)))]
                     [mid-A-B (mid-point A B)]
                     [mid-B-C (mid-point B C)]
                     [mid-A-B-C (mid-point mid-A-B mid-B-C)]
                     [new-lop (list mid-A-B-C)]
                     [left-points (make-curve A mid-A-B-C mid-A-B)]
                     [right-points (make-curve mid-A-B-C C mid-B-C)])
                (append left-points new-lop right-points))]))

; [List-of Posn] -> Image
; produces the image.
(define (render-curve lop)
  (foldr (lambda (next base base-image)
           (add-line base-image
                     (posn-x next)
                     (posn-y next)
                     (posn-x base)
                     (posn-y base)
                     COLOR))
         MT
         (reverse (rest (reverse lop)))
         (rest lop)))


;; auxiliary functions
; Posn Posn Posn -> Boolean 
; is the triangle a, b, c too small to be divided
(define (too-small? a b c)
  (local (; Posn Posn -> Number
          ; Produces the distance between the two point.
          (define (distance point-1 point-2)
            (local ((define x1 (posn-x point-1))
                    (define x2 (posn-x point-2))
                    (define y1 (posn-y point-1))
                    (define y2 (posn-y point-2)))
              (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2)))))))
    (ormap (lambda (point-pair) (>= SMALL (apply distance point-pair)))
            `((,a ,b) (,a ,c) (,b ,c)))))


;; test
(render-curve (make-curve point-A point-C point-B))
(render-curve (make-curve point-A point-C point-B-1))



