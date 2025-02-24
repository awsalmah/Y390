#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define background (rectangle 956 400 255 "black"))

(define star-wars
  (λ (x)
    (cond
      ((< x 100) (overlay(above (text "STAR" (- 200 (* 2 x)) "yellow") (text "WARS" (- 200 (* 2 x)) "yellow")) background))
      (else background))))

(animate star-wars)

(define epigraph1 "A long time ago in a galaxy far,")

(define epigraph2 "far away....")

(define story-text (above (text "It is a period of civil war" 40 "yellow")
                          (text "Rebel spaceships, striking" 40 "yellow")
                          (text "lorem ipsum dolor sit" 40 "yellow")))

(define epigraph-text (above (text epigraph1 40 "blue") (text epigraph2 40 "blue")))

(define shot1 (overlay epigraph-text background))

(define shot3
  (λ (x)
    (star-wars x)))

(define star-wars-opening
  (λ (t)
    (cond
      ((< t 150) shot1)
      ((< t 200) shot1)
      ((< t 300) (shot3 (- t 200)))
      (else (place-image story-text 956/2 (- 470 (- t 300)) background)))))

(animate star-wars-opening)