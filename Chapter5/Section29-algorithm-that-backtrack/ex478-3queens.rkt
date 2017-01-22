;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex478-3queens) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Questions
;; Q1: You can also place the first queen in all squares of
;; the top-most row, the right-most column, and the bottom-most row.
;; Explain why all of these solutions are just like the three scenarios
;; depicted in figure 167?
;; A1: Because all the these position waiting for placing is like the
;; first one -- the left-most column.The 3X3 chessboard looks the same
;; from the right, left, top and the bottom.
;;
;; Q2: This leaves the central square. Is it possible to
;; place even a second queen after you place one on the central square
;; of a 3 by 3 board?
;; A2: It's impossible. Because when the 1st queen place at the central
;; square, the other 8 unoccupied squares are all threatened.