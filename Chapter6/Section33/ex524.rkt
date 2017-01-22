;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex524) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


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


;; main function
; PuzzleState -> Puzzlestate
; according to the given state to show how to solve it.

(define (the-movie state0)
  (local ((define t 3)
          (define answer (solve state0)))
    (run-movie t
               (map render-mc
                    (reverse (cons answer (ps-path answer)))))))


; PuzzleState -> PuzzleState
; is the final state reachable from state0
; generative create a tree of possible boat rides 
; termination encounter the final state.

(define (solve state0)
  (local (; [List-of PuzzleState] -> PuzzleState
          ; generative generate the successors of los
          (define (solve* los)
            (cond
              [(ormap final? los)
               (first (filter final? los))]
              [else
               (solve* (create-next-states los))])))
    (solve* (list state0))))


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


; [List-of PuzzleState] -> [ List-of [List-of PuzzleState] ]
; produces the successors of the given list of ps.

(check-expect (create-next-states `(,init))
              (list
               (make-ps
                (make-pair 2 2)
                "right"
                (make-pair 1 1)
                (list init))
               (make-ps
                (make-pair 3 1)
                "right"
                (make-pair 0 2)
                (list init))
               (make-ps
                (make-pair 3 2)
                "right"
                (make-pair 0 1)
                (list init))))

(define (create-next-states los)
  (local (; PuzzleState -> [List-of PuzzleState]
          ; s is not final state, and on the current location,
          ; the number of missionaries is >=
          ; the number of cannibals, so the avaiable pairs are:
          ; - '(3 3) 
          ; - '(3 2) 
          ; - '(3 1) 
          ; - '(3 0)
          ; - '(2 2) 
          ; - '(2 1) 
          ; - '(2 0)
          ; - '(1 1) 
          ; - '(1 0)
          (define (create-next-states/one s)
            (local ((define left (ps-left s))
                    (define right (ps-right s))
                    (define current-loc (ps-loc s))
                    (define lm (pair-m left))
                    (define rm (pair-m right))
                    (define lc (pair-c left))
                    (define rc (pair-c right))
                    (define 1-1 '(1 1))
                    (define 2-0 '(2 0))
                    (define 0-2 '(0 2))
                    (define 1-0 '(1 0))
                    (define 0-1 '(0 1))
                    ; N N -> [List-of (list N N)]
                    ; produces the satisfied pair of N by the given
                    ; pair of missionaries and cannibals on one side.
                    (define (avaible-pairs m c)
                      (cond [(>= c 2); '(3 3) '(3 2) '(2 2)
                             (list 1-1 2-0 0-2 1-0 0-1)]
                            [(and (>= m 2)
                                  (= c 1)) ; '(3 1) '(2 1)
                             (list 2-0 1-1 1-0 0-1)]
                            [(and (= 1 m)
                                  (= 1 c)) ; '(1 1)
                             (list 1-1 1-0 0-1)]
                            [(>= m 2) ; '(3 0) '(2 0)
                             (list 2-0 1-0)]
                            [else (list 1-0)] ; '(1 0)
                            )))
              (map (lambda (p) (apply create-next-state/pair `(,s ,p)))
                   (if (string=? current-loc "left")
                       (avaible-pairs lm lc)
                       (avaible-pairs rm rc))))))
    (cond [(empty? los) '()]
          [else (append (filter (lambda (s) (and (safe? s)
                                                 (not-repeat? s)))
                                (create-next-states/one (car los)))
                        (create-next-states (cdr los)))])))


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
; PuzzleState (list N N) -> PuzzleState
; produces the next state of given s by the pair of N.

(check-expect (create-next-state/pair init '(1 1))
              (make-state 2 2 "right" 1 1 `(,init)))
(check-expect (create-next-state/pair init '(0 1))
              s1)
(check-expect (create-next-state/pair s1 '(0 1))
              (make-state 3 3 "left" 0 0 `(,s1 ,init)))

(define (create-next-state/pair s lon)
  (local ((define m-sub (car lon))
          (define c-sub (cadr lon))
          (define left (ps-left s))
          (define right (ps-right s))
          (define new-path (cons s (ps-path s))))
    (apply (lambda (edit-num/l edit-num/r location)
             (make-state (edit-num/l (pair-m left) m-sub)
                         (edit-num/l (pair-c left) c-sub)
                         location
                         (edit-num/r (pair-m right) m-sub)
                         (edit-num/r (pair-c right) c-sub)
                         new-path))
           (if (string=? (ps-loc s) "left")
               `(,- ,+ "right")
               `(,+ ,- "left")))))


; PuzzleState -> Boolean
; determines whether the given state is safe for
; missionaries.

(check-expect (safe? s1) #t)
(check-expect (safe? init) #t)
(check-expect (safe? (make-state 2 3 "right" 1 0 `(,init))) #f)
(check-expect (safe? (make-state 2 1 "right" 1 2 '())) #f)

(define (safe? s)
  (local ((define left (ps-left s))
          (define right (ps-right s)))
    (andmap (lambda (side-p)
              (or (= 0 (pair-m side-p))
                  (>= (pair-m side-p) (pair-c side-p))))
            `(,left ,right))))


; PuzzleState -> Boolean
; determines whether the given state do not repeat itself.

(check-expect (not-repeat? (make-state 3 3 "left" 0 0 `(,init)))
              #f)
(check-expect (not-repeat? init) #t)
(check-expect (not-repeat? s1) #t)

(define (not-repeat? s)
  (local ((define path (ps-path s))
          ; PuzzleState PuzzleState -> Boolean
          (define (same-state? orignal new)
            (andmap (lambda (func) (apply equal?
                                          (map func `(,orignal ,new))))
                    `(,ps-left ,ps-right ,ps-loc))))
    (not (ormap (lambda (one-s) (same-state? s one-s))
                path))))


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


;; run program
(the-movie init)

