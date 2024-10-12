#lang racket
(require 2htdp/image)
(circle 30 "solid" "red")
(text "Hello and\nGoodbye" 24 "orange")

(circle 30 "outline" "red")

(place-image
   (triangle 32 "solid" "red")
   0 0
   (rectangle 48 48 "solid" "gray"))
