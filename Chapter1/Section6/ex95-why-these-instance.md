# Exercise 96

 **Q:** Explain why the three instances are generated according to the first or second clause of the data definition.

**A:** 每个实例都有一个需要被构建的原因。

实例一：

```scheme
(make-aim (make-posn 20 10) 
          (make-tank 28 -3))
```

在这里，这个实例用来表示没有发射火箭的正常状态。

实例二：

```scheme
(make-fired (make-posn 20 10)
            (make-tank 28 -3)
            (make-posn 28 (- WORLD-HEIGHT TANK-HEIGHT)))
```

其用来表示已经发射的火箭，这是发射时候的初始状态。

实例三：

```scheme
(make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103))
```

这表示的是靠近时的状态。