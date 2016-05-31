;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.10-editor) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t write repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; ex84
; == the string-module ==
; 1-String
; String consist of one character


; String -> Boolean
; determine weather the string's length is larger than 0-
; examples:
(check-expect (valid-string? "Hello")
              (> (string-length "Hello") 0))
(check-expect (valid-string? "")
              (> (string-length "") 0))

(define (valid-string? str)
  (> (string-length str) 0))


; String -> 1-String
; (string-first str) means extract the fisrt character of str
; then return a 1-String consist of this character
; examples:
(check-expect (string-first "Hello") (string-ith "Hello" 0))
(check-expect (string-first "") "")

(define (string-first str)
  (cond [(valid-string? str) (string-ith str 0)]
        [else ""]))


; String -> String
; (string-rest str) means extract the whole string exclude the
; first character.
; examples:
(check-expect (string-rest "Hello") (substring "Hello" 1))
(check-expect (string-rest "") "")

(define (string-rest str)
  (cond [(valid-string? str) (substring str 1)]
        [else ""]))


; String -> Number
; return the last position of given Stirng
; examples:
(check-expect (last-p "Hello") (- (string-length "Hello") 1))

(define (last-p str) (- (string-length str) 1))


; String -> 1-String
; (string-last str) extract the last character of string
; then return it. If consume a 1-String, just return it.
; examples:
(check-expect (string-last "Hello")
              (substring "Hello" (last-p "Hello")))
(check-expect (string-last "") "")

(define (string-last str)
  (cond [(valid-string? str)
         (substring str (last-p str))]
        [else ""]))


; String -> String
; (string-remove-last str) means remove the last character of
; str, then return the rest.
; examples:
(check-expect (string-remove-last "Hello")
              (substring "Hello" 0 (last-p "Hello")))
(check-expect (string-remove-last "") "")

(define (string-remove-last str)
  (cond [(valid-string? str) (substring str 0 (last-p str))]
        [else ""]))

; == the string-module ==

(define-struct editor [pre post])
; Editor = (make-editor String String)
; interpretation (make-editer s t) means the text in the editor is
; (string-append s t) with the cursor displayed between s and t

(define ed1 (make-editor "hello" "world"))
(define long-ed (make-editor "a string that is to lonnnnnnnnnnng" ""))
(define ed3 (make-editor "" "left is empty!"))
(define ed4 (make-editor "right is empty!" ""))
(define equal-ed (make-editor "abcdefdsfasdfdasfdsafdsafd" ""))


; KeyEvents
; - 1-String: insert it into editor-pre
; - "\b": delete one string in the left of cursor, if any
; - "left" and "right": move a character from pre to post, vice
; versa, if any.


; graphic constants
(define CURSOR (rectangle 1 20 "solid" "red"))
(define BKG (empty-scene 200 20))
(define SIZE 16)
(define COLOR "black")


; String -> Image
; help render t into Image

(define (text/auxi t)
  (text t SIZE COLOR))


; Editor -> Image
; render the Editor to an Image, the cursor is between s and t
; examples:
(check-expect
 (render ed1)
 (overlay/align "left" "center"
                (beside (text/auxi (editor-pre ed1))
                        CURSOR
                        (text/auxi (editor-post ed1)))
                BKG))
(check-expect
 (render ed3)
 (overlay/align "left" "center"
                (beside (text/auxi (editor-pre ed3))
                        CURSOR
                        (text/auxi (editor-post ed3)))
                BKG))

(define (render ed)
  (overlay/align "left" "center"
                 (beside (text/auxi (editor-pre ed))
                         CURSOR
                         (text/auxi (editor-post ed)))
                 BKG))


; ex86
; Editor -> Boolean
; determine weather to render or input the character
; if too wide(width large than or equals),
; return #true; else return #false.
; examples:
(check-expect (text-width long-ed) #t)
(check-expect (text-width ed1) #f)

(define (text-width ed)
  (>= (image-width (beside (text/auxi (editor-pre ed))
                          CURSOR
                          (text/auxi (string-append (editor-post ed) " "))))
     (image-width BKG)))


; ex84
; Editor KeyEvnet -> Editor
; interpretation (edit ed ke) means the ke changes the ed
; if ke is 1-String exclude "\t" "\r" "\b", insert it into ed-pre
; else if ke is "\b", delete a character in ed-pre
; else if ke is "left" or "right", then move one character from
; ed-pre to ed-post or vice versa, if any.
; examples:
; normal editor, both side is not empty
(check-expect (edit ed1 " ") (make-editor (string-append (editor-pre ed1) " ")
                                          (editor-post ed1)))
(check-expect (edit ed1 "\b") (make-editor (string-remove-last (editor-pre ed1))
                                           (editor-post ed1)))
(check-expect (edit ed1 "\t") ed1)
(check-expect (edit ed1 "left") (make-editor (string-remove-last (editor-pre ed1))
                                             (string-append (string-last (editor-pre ed1))
                                                            (editor-post ed1))))
(check-expect (edit ed1 "right") (make-editor (string-append (editor-pre ed1)
                                                             (string-first (editor-post ed1)))
                                              (string-rest (editor-post ed1))))
(check-expect (edit ed1 "up") ed1)

; special editor, the left side is empty
(check-expect (edit ed3 " ") (make-editor " " (editor-post ed3)))
(check-expect (edit ed3 "\b") (make-editor (editor-pre ed3) (editor-post ed3)))
(check-expect (edit ed3 "left") ed3)
(check-expect (edit ed3 "right") (make-editor (string-first (editor-post ed3))
                                              (string-rest (editor-post ed3))))

; special editor, the right side is empty
(check-expect (edit ed4 " ") (make-editor (string-append (editor-pre ed4) " ") ""))
(check-expect (edit ed4 "\b") (make-editor (string-remove-last (editor-pre ed4)) ""))
(check-expect (edit ed4 "left") (make-editor (string-remove-last (editor-pre ed4))
                                             (string-last (editor-pre ed4))))
(check-expect (edit ed4 "right") ed4)

; special editor, the length sum of left side and right side is equal to width of BKG
(check-expect (edit equal-ed " ") equal-ed)
(check-expect (edit equal-ed "\b") (make-editor (string-remove-last (editor-pre equal-ed)) ""))
(check-expect (edit equal-ed "left") (make-editor (string-remove-last (editor-pre equal-ed))
                                                  (string-last (editor-pre equal-ed))))
(check-expect (edit equal-ed "right") equal-ed)

(define (edit ed ke)
  (cond [(= (string-length ke) 1)
         (cond [(string=? "\b" ke)
                (make-editor (string-remove-last (editor-pre ed))
                             (editor-post ed))]
               [(and (<= 32 (string->int ke) 126) (not (text-width ed)))
                (make-editor (string-append (editor-pre ed) ke)
                             (editor-post ed))]
               [else ed])]
        [(string=? "left" ke)
         (make-editor (string-remove-last (editor-pre ed))
                      (string-append (string-last (editor-pre ed))
                                     (editor-post ed)))]
        [(string=? "right" ke)
         (make-editor (string-append (editor-pre ed)
                                     (string-first (editor-post ed)))
                      (string-rest (editor-post ed)))]
        [else ed]
        ))


(define (run input)
  (big-bang (make-editor input "")
            [to-draw render]
            [on-key edit]))

(run "")









