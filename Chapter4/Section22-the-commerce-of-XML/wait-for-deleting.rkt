;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname wait-for-deleting) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)


;; data difinitions
(define-struct data [name coins])
; A BilibiliData is a structure: (make-data String Number)


;; constants
(define PREFIX "http://www.bilibili.com/video/")
(define SUFFIX "/")
(define SIZE 24)

(define a0 '((initial "X")))
(define a1 '((initial "X") (exact "true") (support-1.1 "true")))
(define a2 '((exact "true") (racket-version "6.5[3m]")))

(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))



;; functions
; String -> BilibiliData
; retrieves the v_ctimes of av-code.
;(define (bilibili-coin av-code)
;  (local ((define path-to-av (string-append av-code ".xml"))
;          ; String -> BilibiliData
;          (define (retrieve-data w)
;            (local ((define x (real (read-xexpr path-to-av))))
;              (make-data (get x '(title))
;                         (get-content '("info"
;                                        "v-title-info"
;                                        "v-title-line"
;                                        "v_ctimes")))))
;
;          ; BilibiliData -> Image
;          (define (render-bilibili-data w)
;            (local (; [BilibiliData -> String] -> Image
;                    (define (word sel col)
;                      (text (sel w) SIZE col)))
;              (overlay (baside (word data-name 'black)
;                               (text "  " SIZE 'white)
;                               (word (number->string data-coins) 'red))
;                       (rectangle 300 25 'solid 'white)))))
;    (render-bilibili-data )))


; Xexpr -> Xexpr
; get the plain xexpr without any string contains "\n" or "\t".

(check-expect (real '(div ((class "v-title-info")) "\n\t"))
              '(div ((class "v-title-info"))))
(check-expect (real '(div ((class "v-title-info")) "\n\t"
                          (div ((class "v-title-line")) "\n\t\t"
                               (i ((title "播放") (class "b-icon b-icon-a b-icon-play")))
                               (span ((id "dianji")) 260772))))
              '(div ((class "v-title-info"))
                          (div ((class "v-title-line"))
                               (i ((title "播放") (class "b-icon b-icon-a b-icon-play")))
                               (span ((id "dianji")) 260772))))

(define (real xe)
  (local ((define tag (first xe))
          (define attrs (xexpr-attr xe))
          (define content (xexpr-content xe))
          (define (no-space c)
                  (filter (lambda (item) (if (string? item)
                                             (not (or (string-contains? "\t" item)
                                                      (string-contains? "\n" item)))
                                             #true)) c)))
    (cons tag (cons attrs (cons (no-space content) '())))))


;; auxiliary functions
; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the content of the given xe by list of xexpr.

(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '((action)))
(check-expect (xexpr-content e3) '((action)))
(check-expect (xexpr-content e4) '((action) (action)))

(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond [(empty? optional-loa+content) '()]
          [else (local ((define c-or-loa (first optional-loa+content)))
                  (if (list-of-attributes? c-or-loa)
                      (rest optional-loa+content)
                      optional-loa+content))])))


; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe.

(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) a0)
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) a0)

(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond [(empty? optional-loa+content) '()]
          [else (local ((define loa-or-x (first optional-loa+content)))
                     (if (list-of-attributes? loa-or-x)
                         loa-or-x
                         '()))])))


; [List-of Attribute] or Xexpr.v2 -> Boolean
; determine whether x is an element of [List-of Attribute]
; #false otherwise

(check-expect (list-of-attributes? a0) #true)
(check-expect (list-of-attributes? '()) #true)
(check-expect (list-of-attributes? '(action)) #false)

(define (list-of-attributes? x)
  (cond [(empty? x) #true]
        [else (local ((define possible-attribute (first x)))
                (cons? possible-attribute))]))


; [List-of Attribute] Symbol -> [Maybe String]
; produces the pair which starts with the given attr in the la;
; #false otherwise.

(check-expect (find-attr a0 'initial) '(initial "X"))
(check-expect (find-attr a1 'support-1.1) '(support-1.1 "true"))
(check-expect (find-attr a2 'initial) #false)

(define (find-attr al attr)
  (assq attr al))








