# Prologue's main content

The prologue introduces the main point to start programing.It contains the basic content of BSL language, like calculations about numbers, pre-defined functions about strings, operations for combining Boolean values and so on. In addition, it introduces a teachpack named *2htdp/image*, which supports operations for operations about the images, and it use the lib to design the main program of this chapter -- a series of racket-fly.rkt.

The file [FunctionSign](FunctionSign.rkt) is a litte trying of the content in [Many ways to Compute](http://www.ccs.neu.edu/home/matthias/HtDP2e/part_prologue.html#%28part._pro-cond%29), and all of [FunctionSign](FunctionSign.rkt) could be found in the this section.

The series file racket-fly is the main part of this chapter. Let me introduce these file one by one.The [1st version of racket-fly](racket-flyV1.rkt) just add a racket to the empty scene. If you want a dynamic version, you nee apply the function animate like what I had done. The image is the following one:![rocket](http://www.ccs.neu.edu/home/matthias/HtDP2e/rocket.png). But you will find that this rocket cannot stop. The next version may solve this problem.

The [2nd version of racket-fly](racket-flyV2.rkt) adds cond clause to help stop this rocket. As the code shows, the racket will stop when the height is larger than 100. Another question comes that the rocket are not landed on the bottom -- it lands belows the bottom. It's strange.

The [3rd version of racket-fly](racket-flyV3.rkt) modify the condition expression so this program could compute the real position of the picture, not the approximate one. Now the rocket can be landed on the bottom, what should we do next?

As [One Program, Many Difinitions](http://www.ccs.neu.edu/home/matthias/HtDP2e/part_prologue.html#%28part._more-def%29) shows, all you need is more difinitions to tell what the value and meaning of constants, like the real height of rocket, and so that you could change the porgram in one place, make it work all other places. And this is what the [4th version of racket-fly](racket-flyV4.rkt) does.

And now you found a program: expression `(- HEIGHT (/ (image-height ROCKET) 2))` occurs 3 times, which means the program need to compute it 3 times, and we readers need more efforts to understand what it means. This cannot be a good code, like someone said, "Don't Repeat Youself." We acturally need a more simply version of `picture-of-rocket`, and this idea make the [5th version of racket-fly](racket-flyV5.rkt) comes out.

Finally, we want the rocket landed more really, maybe we could change the speed of rocket by an additional function. For that reaon, the [6th version of racket-fly](racket-flyV6.rkt) comes out.

That's all. Like the end of prologue tells you:**You Are a Programmer Now**. 