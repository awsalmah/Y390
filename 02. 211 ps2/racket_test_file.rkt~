#lang racket
(require 2htdp/image)
(circle 30 "solid" "red")
(text "Hello and\nGoodbye" 24 "orange")

(circle 30 "outline" "red")

(place-image
   (triangle 32 "solid" "red")
   0 0
   (rectangle 48 48 "solid" "gray"))

(place-image
   (triangle 32 "solid" "red")
   24 24
   (rectangle 48 48 "solid" "gray"))

(place-image
   (triangle 64 "solid" "red")
   24 24
   (rectangle 48 48 "solid" "gray"))

(place-image
   (circle 4 "solid" "white")
   18 20
   (place-image
    (circle 4 "solid" "white")
    0 6
    (place-image
     (circle 4 "solid" "white")
     14 2
     (place-image
      (circle 4 "solid" "white")
      8 14
      (rectangle 24 24 "solid" "goldenrod")))))

(circle 20 "outline" "red")
(circle 20 "solid" "blue")
(circle 20 100 "blue")
(circle 20 "outline" (pen "red" 2 "long-dash" "round" "bevel"))
;; (circle 20 "solid" (pen "red" 2 "long-dash" "round" "bevel"))
;; (circle 20 199 (pen "red" 2 "long-dash" "round" "bevel"))
;; solid and number modes can only take a color whereas outline takes a color or a pen struct
(define x 1)
(overlay (circle 20 "solid" "blue")
(circle 200 255 "red"))
;; (overlay (circle 20 "solid" "blue") x) this raises an error
(rhombus 40 45 "solid" "magenta")
(rhombus 100 180 "solid" "red")
(rhombus 40 3 "solid" "magenta")
