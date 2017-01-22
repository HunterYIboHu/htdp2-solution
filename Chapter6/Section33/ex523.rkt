;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex523) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require 2htdp/image)


;; graphic constants
(define missionary (circle 5 "solid" "black"))
(define cannibal (circle 5 "outline" "black"))
(define side (rectangle 30 40 "outline" "black"))
(define wave (text "~~" 10 "black"))
(define boat (rhombus 8 30 "solid" "black"))
(define no-wave-river (rectangle 20 40 "outline" "black"))


;; data definitions
(define-struct ps [left loc right path])
; PuzzleState is (make-ps Pair Location Pair [List-of PuzzleState])
; 'left represents the combination of the missionaries and cannibals
; on the left side of the river; 'right represents the combination of
; the missionaries and cannibals on the right side of the river;
; 'loc represent the location of the boat.
; 'path records the PuzzleState traversed to get there.

(define-struct pair [m c])
; Pair is (make-pair N N)
; m represents the number of missionaries, c represents the number of
; cannibals.

; Location is one of:
; - "left"
; - "right"


;; constructor
; Any -> Boolean
; determines whether the given s is a Location.

(check-expect (location? "left") #t)
(check-expect (location? "right") #t)
(check-expect (location? 1) #f)

(define (location? s)
  (and (string? s)
       (member? s '("left" "right"))))


; N N N N -> (list Pair Pair)
; produces a pair of Pair, 'lm represents the left part's
; missionaries;
; 'lc represents the left part's cannibals;
; 'rm represents the right part's missionaries;
; 'rc represents the right part's missionaries.
; and the legal input should satisfied all following conditions:
; 1. the sum of '(lm lc rm rc) is 6;
; 2. the sum of missionaries and cannibals are both 3.
; if not satisfied the above conditions, it would signals an error.

(check-expect (create-pairs 3 3 0 0)
              `(,(make-pair 3 3)
                ,(make-pair 0 0)))
(check-expect (create-pairs 3 2 0 1)
              `(,(make-pair 3 2)
                ,(make-pair 0 1)))
(check-error (create-pairs 3 2 0 0))
(check-error (create-pairs 3 1 2 0))

(define (create-pairs lm lc rm rc)
  (local ((define prefix "Illegal input! ")
          ; String -> String
          ; produces the error message by adding prefix to
          ; the given string.
          (define (error-msg m)
            (error (string-append prefix m))))
    (cond [(not (= 6 (foldr + 0 `(,lm ,lc ,rm ,rc))))
           (error-msg "The sum of (list lm lc rm rc) is not 6.")]
          [(not (= 3 (+ lm rm)))
           (error-msg "The total number of missionaries is not 3")]
          [else (list (make-pair lm lc)
                      (make-pair rm rc))])))


; N N String N N [List-of PuzzleState]-> PuzzleState
; produces a PuzzleState by the given arguments.
; the legal input should satisfied all following conditions:
; the sum of '(lm lc rm rc) is 6;
; the sum of missionaries and cannibals are both 3;
; loc is a Location.
; otherwise would signals an error.
; P.S. the first 2 conditions are judged by 'create-pairs.

(check-expect (make-state 3 3 "left" 0 0 '())
              (make-ps (make-pair 3 3)
                       "left"
                       (make-pair 0 0)
                       '()))
(check-expect (make-state 3 2 "right" 0 1 `(,init))
              (make-ps (make-pair 3 2)
                       "right"
                       (make-pair 0 1)
                       `(,init)))
(check-error (make-state 3 2 "up" 0 1 '()))
(check-error (make-state 3 3 "right" 0 0 '(1)))

(define (make-state lm lc loc rm rc path)
  (local ((define pairs (create-pairs lm lc rm rc))
          (define left (car pairs))
          (define right (cadr pairs))
          (define prefix "make-state: Illegal input! ")
          ; String -> String
          ; produces the error message by adding prefix to
          ; the given string.
          (define (error-msg m)
            (error (string-append prefix m))))
    (cond [(not (location? loc))
           (error-msg (string-append "The loc "
                                     loc
                                     " is not a location."))]
          [(not (andmap ps? path))
           (error-msg "The path is not all PuzzleState.")]
          [else (make-ps left loc right path)])))


;; data examples
(define init (make-ps (make-pair 3 3)
                      "left"
                      (make-pair 0 0)
                      '()))
(define s1 (make-state 3 2 "right" 0 1
                       `(,init)))
(define f1 (make-state 0 0 "right" 3 3
                       '()))


;; functions
; PuzzleState -> Boolean
; determines whether a given PuzzleState is an final one.

(check-expect (final? f1) #t)
(check-expect (final? s1) #f)

(define (final? s)
  (local ((define left (ps-left s))
          (define right (ps-right s))
          ; Piar -> (list N N)
          ; translate the given pair into [List N].
          (define (pair->list p)
            (list (pair-m p) (pair-c p))))
    (and (string=? (ps-loc s) "right")
         (andmap zero? (pair->list left))
         (andmap (lambda (num) (= 3 num))
                 (pair->list right)))))


; PuzzleState -> Image
; render the given state into image.

(check-expect (render-mc init)
              (beside (render-side 3 3)
                      (render-river "left")
                      (render-side 0 0)))
(check-expect (render-mc s1)
              (beside (render-side 3 2)
                      (render-river "right")
                      (render-side 0 1)))
(check-expect (render-mc f1)
              (beside (render-side 0 0)
                      (render-river "right")
                      (render-side 3 3)))

(define (render-mc state)
  (local ((define lm (pair-m (ps-left state)))
          (define rm (pair-m (ps-right state)))
          (define lc (pair-c (ps-left state)))
          (define rc (pair-c (ps-right state)))
          (define location (ps-loc state)))
    (beside (render-side lm lc)
            (render-river location)
            (render-side rm rc))))


;; auxiliary functions
; Location -> Image
; render the image of river when the boat is at current
; loc.

(check-expect (render-river "left")
              (overlay/align "middle" "middle"
                             (above wave (beside boat wave) wave)
                             no-wave-river))
(check-expect (render-river "right")
              (overlay/align "middle" "middle"
                             (above wave (beside wave boat) wave)
                             no-wave-river))

(define (render-river loc)
  (overlay/align "middle" "middle"
                 (above wave
                        (if (string=? "left" loc)
                            (beside boat wave)
                            (beside wave boat))
                        wave)
                 no-wave-river))


; N N -> Image
; render missionary and cannibal on one side.

(check-expect (render-side 0 0) side)
(check-expect (render-side 2 3)
              (overlay/align "middle" "middle"
                             (beside (apply above (make-list 2 missionary))
                                     (apply above (make-list 3 cannibal)))
                             side))
(check-expect (render-side 3 0)
              (overlay/align "middle" "middle"
                             (apply above (make-list 3 missionary))
                             side))
(check-expect (render-side 0 3)
              (overlay/align "middle" "middle"
                             (apply above (make-list 3 cannibal))
                             side))

(define (render-side m c)
  (cond [(andmap zero? (list m c)) side]
        [else (local (; N Image -> Image
                      ; help render the aboved people.
                      (define (render-people n img)
                        (if (zero? n)
                            empty-image
                            (apply above (cons empty-image (make-list n img))))))
                (overlay/align "middle"
                               "middle"
                               (beside (render-people m missionary)
                                       (render-people c cannibal))
                               side))]))









