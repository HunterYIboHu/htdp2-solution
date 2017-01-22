;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname parse-bilibili) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; data difinitions
(define-struct av-data [title av-code click barrange coin])
; Data is (define-struct String String Number Number Number)
; the click is the click number of the video, the barrange is the
; dm_count of the video, the coin is the coin number of the video.

(define av532922 (make-av-data "【洛天依】自挂东南枝（献给六月高考的孩纸"
                               "532922" 260772 6125 672))


;; constants
(define xe1 '(machine ()
                      (action ((next "green")
                               (state "red")))
                      "no use."))
(define xe2 '(machine ((initial "black"))
                      (action ((state "black") (next "white")))
                      (action ((state "white") (next "black")))))
(define xe3 '(div ((class "v-title-line"))
                                (i ((class "b-icon b-icon-a b-icon-play")
                                    (title "播放")))
                                (span ((id "dianji")) "260772")))
(define xe4 '(machine))
(define xe5 '(no-attr (action ((content "nothing")))))

(define xe-av532922 (read-xexpr "C:\\Users\\HuYibo\\Application\\HtDP-for-git\\Chapter4\\Section22-the-commerce-of-XML\\av532922.xml"))
(define HOME "C:\\Users\\HuYibo\\Application\\HtDP-for-git\\Chapter4\\Section22-the-commerce-of-XML\\")


;; functions
; String -> Data
; produces the given file's content's information.

(check-expect (get-information "532922")
              (make-av-data "【洛天依】自挂东南枝（献给六月高考的孩纸" "532922" 260772 6125 672))

(define (get-information av)
  (local ((define xml-file (string-append HOME "av" av ".xml"))
          (define xe-av (read-xexpr xml-file))
          (define title-element (get-element-by-names xe-av '(div div h1)))
          (define click "dianji")
          (define barrange "dm_count")
          (define coin "v_ctimes")
          ; String -> Xexpr
          ; get the spefic element by the given attr's value.
          (define (get-element value)
            (get-element-by-attr xe-av 'id value)))
    (apply make-av-data
           `(,(xexpr-content title-element)
             ,av
             ,@(map (lambda (value) (string->number (xexpr-content (get-element value))))
                    `(,click ,barrange ,coin))))))


; Xexpr [List-of Symbol] -> [Maybe Xexpr]
; produces the first element which is follow the given order of tags.
; BUGS: if the there are many tag has the same name, it could find the correct one.

(check-expect (get-element-by-names xe3 '(div span))
              '(span ((id "dianji")) "260772"))
(check-expect (get-element-by-names xe2 '(machine action))
              '(action ((state "black") (next "white"))))
(check-expect (get-element-by-names '(machine) '()) #false)
(check-expect (get-element-by-names '(machine) '(machine 'no-tag)) #false)
(check-expect (get-element-by-names xe-av532922 '(div div h1))
              '(h1 ((title "【洛天依】自挂东南枝（献给六月高考的孩纸"))
                   "【洛天依】自挂东南枝（献给六月高考的孩纸"))

(define (get-element-by-names xe lon)
  (cond [(empty? lon) #false]
        [else (local ((define cleaned (clean-xexpr xe))
                      (define tag-name (xexpr-name cleaned))
                      (define current-tag (first lon)))
                (if (symbol=? tag-name current-tag)
                    (if (empty? (rest lon))
                        xe
                        (local ((define l (filter (lambda (i) (cons? i))
                                                  (map (lambda (item) (get-element-by-names item (rest lon)))
                                                       (xexpr-sub cleaned)))))
                          (if (empty? l)
                              #false
                              (first l))))
                    #false))]))


; Xexpr Symbol String -> [Maybe Xexpr]
; produces the first element whose attr and value is the given one.
; BUG: I don't know where ...

(check-expect (get-element-by-attr xe5 'content "nothing")
              '(action ((content "nothing"))))
(check-expect (get-element-by-attr xe5 'content "something") #false)

(define (get-element-by-attr xe attr value)
  (local ((define cleaned (clean-xexpr xe))
          (define maybe-attr (assoc attr (xexpr-attrs cleaned))))
    (if (and (cons? maybe-attr)
             (string=? value (second maybe-attr)))
        xe
        (local ((define l (filter (lambda (i) (cons? i))
                                  (map (lambda (item) (get-element-by-attr item attr value))
                                       (xexpr-sub cleaned)))))
          (if (empty? l)
              #false
              (first l))))))


; Xexpr -> Xexpr
; get the xexpr without "\n" or "\t" in the content.

(check-expect (clean-xexpr xe1) '(machine (action ((next "green") (state "red"))) "no use."))
(check-expect (clean-xexpr xe3) '(div ((class "v-title-line"))
                                      (i ((class "b-icon b-icon-a b-icon-play")
                                          (title "播放")))
                                      (span ((id "dianji")) "260772")))
(check-expect (clean-xexpr '(div (i ((class "b-video")) "\n    ")
                                 "\t"))
              '(div (i ((class "b-video")))))

(define (clean-xexpr xe)
  `(,(xexpr-name xe)
    ,@(if (empty? (xexpr-attrs xe))
          '()
          `(,(xexpr-attrs xe)))
    ,@(map clean-xexpr (filter (lambda (l) (cons? l)) (xexpr-sub xe)))
    ,@(local ((define content (xexpr-content xe)))
        (if (or (false? content)
                (ormap (lambda (str) (string-contains? str content)) '("\n" "\t" "  ")))
            '()
            `(,content)))))


;; auxiliary functions
; Xexpr -> Symbol
; produces the element's name.

(check-expect (xexpr-name xe1) 'machine)
(check-expect (xexpr-name xe2) 'machine)
(check-expect (xexpr-name xe3) 'div)

(define (xexpr-name xe)
  (first xe))


; Xexpr -> [List-of Attribute]
; produces the element's attrs

(check-expect (xexpr-attrs xe1) '())
(check-expect (xexpr-attrs xe2) '((initial "black")))
(check-expect (xexpr-attrs xe4) '())
(check-expect (xexpr-attrs xe5) '())
(check-expect (xexpr-attrs '(machine "nothing")) '())

(define (xexpr-attrs xe)
  (local ((define content-and-attrs (rest xe)))
    (cond [(empty? content-and-attrs) '()]
          [(empty? (first content-and-attrs)) '()]
          [(list-of-attrs? (first content-and-attrs))
           (first content-and-attrs)]
          [else '()])))


; Xexpr -> [List-of Xexpr]
; prodcues the element's sub-elements

(check-expect (xexpr-sub xe1) '((action ((next "green") (state "red")))))
(check-expect (xexpr-sub xe2) '((action ((state "black") (next "white")))
                                (action ((state "white") (next "black")))))
(check-expect (xexpr-sub xe3) '((i ((class "b-icon b-icon-a b-icon-play")
                                    (title "播放")))
                                (span ((id "dianji")) "260772")))
(check-expect (xexpr-sub xe4) '())
(check-expect (xexpr-sub xe5) '((action ((content "nothing")))))

(define (xexpr-sub xe)
  (local ((define result (rest xe)))
    (cond [(empty? result) '()]
          [(or (empty? (first result))
               (list-of-attrs? (first result)))
           (get-elements (rest result))]
          [else (get-elements result)])))


; Xexpr -> [Maybe String]
; produces the tag's content in the element.

(check-expect (xexpr-content xe1) "no use.")
(check-expect (xexpr-content xe4) #false)
(check-expect (xexpr-content xe5) #false)

(define (xexpr-content xe)
  (if (string? (first (reverse xe)))
      (first (reverse xe))
      #false))


; Xexpr Or [List-of Attribute] -> Boolean
; determine whether the given input is [List-of Attribute]

(check-expect (list-of-attrs? '(action ((content "nothing")))) #f)
(check-expect (list-of-attrs? '((initial "black"))) #t)

(define (list-of-attrs? l)
  (and (cons? l)
       (cons? (first l))))


; (cons [List-of Xexpr] [String Or '()]) -> [List-of Xexpr]
; produces the XML-elements in the given l.

(check-expect (get-elements '((action ((next "green") (state "red"))) "no use."))
              '((action ((next "green") (state "red")))))
(check-expect (get-elements '((action ((state "black") (next "white")))
                              (action ((state "white") (next "black")))))
              '((action ((state "black") (next "white")))
                (action ((state "white") (next "black")))))
(check-expect (get-elements '("260772")) '())

(define (get-elements l)
  (cond [(empty? l) '()]
        [(empty? (rest l)) (if (string? (first l))
                               '()
                               `(,(first l)))]
        [else (cons (first l)
                    (get-elements (rest l)))]))

