;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex511-fmt) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


;; constants
(define MAX 80)


;; data examples
(define test-in (read-words/line "test-in.txt"))
(define test-in/lines (read-lines "test-in.txt"))

(define in-name "test-in.txt")
(define out-name "test-out.txt")


;; main functions
; String String -> String
; format the in's content, and write it to the out's file.

(define (fmt in out)
  (fmt-file (read-words/line in) out MAX))


;; auxiliary functions
; [List-of String] -> String
; produces a string ends with \r\n according to line.

(check-expect (line->string (first test-in))
              (string-append (first test-in/lines) "\r\n"))
(check-expect (line->string '()) "\r\n")

(define (line->string line)
  (if (empty? line)
      "\r\n"
      (string-append (substring (foldl (lambda (w base)
                                         (string-append base " " w))
                                       ""
                                       line)
                                1)
                     "\r\n")))


; [List-of String] -> [List String [List-of String]]
; format line0 at length less than given len, produces a pair, the
; first is the formated line, the second is the removed words.

(check-expect (fmt-line '("hello" "world") 11)
              '("hello world\r\n" ()))
(check-expect (fmt-line '("hello" "world") 8)
              '("hello\r\n" ("world")))
(check-expect (fmt-line '("hello" "world") 4)
              '("\r\n" ("hello" "world")))

(define (fmt-line line0 len)
  (local (; [List-of String] [List-of String]
          ; -> [List String [List-of String]]
          (define (fmt-line/a line removed)
            (cond [(<= (- (string-length (line->string line))
                         2)
                      len)
                   (list (line->string (reverse line)) removed)]
                  [else (fmt-line/a (rest line)
                                    (cons (first line) removed))]))
          )
    (fmt-line/a (reverse line0) '())))


; [List-of [List-of String]] String -> String
; write the formated content into the file named out.

(define (fmt-file content out len)
  (local (; String -> String
          ; write the given content into file.
          (define (write-out str)
            (write-file out str))
          
          ; [List-of String] [List-of [List-of String]] String
          ; -> String
          (define (fmt-file/a line rest-lines str)
            (cond [(and (empty? line) (empty? rest-lines))
                   (write-out str)]
                  [(empty? rest-lines)
                   (local ((define fmted (fmt-line line len))
                           (define line-str (first fmted))
                           (define removed (second fmted)))
                     (fmt-file/a removed
                                 '()
                                 (string-append str line-str)))]
                  [else (local ((define fmted (fmt-line line len))
                                (define line-str (first fmted))
                                (define removed (second fmted)))
                          (fmt-file/a (append removed
                                              (first rest-lines))
                                      (rest rest-lines)
                                      (string-append str line-str)))]))
          )
    (if (empty? content)
        (write-out "")
        (fmt-file/a (first content)
                    (rest content)
                    ""))))


;; launch
(fmt "test-in.txt" "test-out-2.txt")


