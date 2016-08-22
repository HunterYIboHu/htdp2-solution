#lang web-server/insta


; String String -> ... deeply nested list ...
; produces a web page with given author and title
(define (my-first-web-page author title)
  `(html
    (head
     (title ,title)
     (meta ((http-equiv "content-type")
            (content "text-html"))))
    (body
     (h1 ,title)
     (p "I " ,author ", made this page."))))


(define (start request)
  (response/xexpr
   (my-first-web-page "HuYibo" "Blog")))
