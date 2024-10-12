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