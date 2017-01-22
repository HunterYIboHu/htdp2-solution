;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex315-改) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)


;; data difinitions
(define-struct no-parent [])
(define NP (make-no-parent))
(define-struct child [father mother name date eyes])
; A FT (short for family tree) is one of: 
; – NP
; – (make-child FT FT String N String)

; A FF (short for family forest) is [List-of FT]
; interpretation a family forest represents several
; families (say a town) and their ancestor trees


;; constants
; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; Family forests
(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

; Pyhsical constants
(define CURRENT 2016)


;; functions
; FF N -> N
; 返回家族森林中所有实例的平均年龄（假设他们都还活着）。

(check-expect (average-age/new ff1 CURRENT) 90)
(check-expect (average-age/new ff2 CURRENT) 70.25)
(check-expect (average-age/new ff3 CURRENT) 70.25)

(define (average-age/new a-ff0 current0)
  (local ((define EMPTY-FOREST '()) ; 已经存在的家族成员，初始没有任何家族成员。
          (define INIT-AGE 0) ; 当前的家族成员总岁数，初始为0.
          ; FF N FF -> N
          ; 返回家族森林中所有实例的平均年龄（假设他们都还活着）。
          ; 累加器：families，记录已经出现的家族成员。
          (define (average-age/a a-ff current families total-age)
            (cond [(empty? a-ff) (/ total-age (length families))]
                  [else (if (member? (first a-ff) families) ; 当前家族树曾经出现过
                            (average-age/a (rest a-ff)
                                           current
                                           families
                                           total-age) ; 忽略当前家族树，计算家族森林中的下一个家族数。
                            (average-age/a (rest a-ff)
                                           current
                                           (add-members (first a-ff) families)
                                           (+ total-age
                                              (compute-age/all (first a-ff) current))) ; 将当前家族树纳入计算中
                            )]))

          ; FT FF -> N
          ; 将家族树及其子树加入到家族森林中，已经存在的家族成员不需要更新。
          (define (add-members a-ft old-ff)
            (if (equal? NP a-ft) ; 判断当前家族树是否为空树
                old-ff ; 如果家族树为空，则返回没有变化的家族森林
                (local ((define left-tree (child-father a-ft))
                        (define right-tree (child-mother a-ft)))
                  (add-members right-tree
                               (add-members left-tree
                                            (if (member? a-ft old-ff)
                                                old-ff
                                                (cons a-ft old-ff))))) ; 否则，将家族树中所有成员加入到家族森林中，已经加入的家族成员不再重复计算。
                ))
          ; FT N -> N
          ; 计算出该家族数中所有成员的年龄总和（假设他们都还活着）
          (define (compute-age/all a-ft now)
            (local ((define left (child-father a-ft))
                    (define right (child-mother a-ft)))
              (+ (compute-age/one a-ft now)
                 (if (equal? NP left)
                     0
                     (compute-age/all left now))
                 (if (equal? NP right)
                     0
                     (compute-age/all right now)))))
          ; FT N -> N
          ; 计算出给定的一个家族成员的年龄（假设他还活着）
          (define (compute-age/one person now)
            (- now (child-date person)))
          )
    (average-age/a a-ff0 current0 '() 0)))


; [List-of FT] N -> N
; produces the average age of all child instance in the forest,
; assuming that the trees in the given forest don't overlap.

(check-expect (average-age ff1 CURRENT) 90)
(check-expect (average-age ff2 CURRENT) 70.25)

(define (average-age a-ff current)
  (local ((define (sum l)
            (foldr + 0 l)))
    (/ (sum (map (lambda (ft) (sum-age ft current)) a-ff))
       (sum (map count-persons a-ff)))))


;; auxiliary functions
; FT -> Number
; counts the child structures in a-ftree.

(check-expect (count-persons Carl) 1)
(check-expect (count-persons Eva) 3)
(check-expect (count-persons Gustav) 5)

(define (count-persons a-ftree)
  (match a-ftree
    [(? no-parent?) 0]
    [(child fa mo n d e) (+ (count-persons fa)
                            (count-persons mo)
                            1)]))


; FT Number -> Number
; produces the total age of all child in a-ftree, assuming that
; they all alive now.

(check-expect (sum-age Carl CURRENT) 90)
(check-expect (sum-age Eva CURRENT) 231)
(check-expect (sum-age Gustav CURRENT) 309)

(define (sum-age a-ftree current)
  (match a-ftree
    [(? no-parent?) 0]
    [(child fa mo n d e) (+ (sum-age fa current)
                            (sum-age mo current)
                            (- current d))]))