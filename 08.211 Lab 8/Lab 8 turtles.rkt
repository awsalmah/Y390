;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |ps8 turtles|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 211: Turtle graphics

(require 2htdp/image)

; A Trip is one of:
; - empty
; - (cons Step Trip)
 
; A Step is one of:
; - (make-draw Number)
; - (make-turn Number)
; *Interpretation*: angle is how many degrees to turn left (counterclockwise)
(define-struct draw [distance])
(define-struct turn [angle])

;; examples of trips
(define square-trip
  (list (make-draw 50)
        (make-turn 90)
        (make-draw 50)
        (make-turn 90)
        (make-draw 50)
        (make-turn 90)
        (make-draw 50)))
(define z-trip
  (list (make-draw 80)
        (make-turn -135)
        (make-draw 120)
        (make-turn 135)
        (make-draw 80)))

;; Exercise 1. Design a function step-length that computes the length of a Step.
;; In other words, this function should compute how much ink is used by the given Step.
;; Turning doesn’t draw anything, so the length of a turn is 0.
(define step-length
  (λ (s)
    (cond
      ((turn? s) 0)
      (else (draw-distance s)))))

;; Exercise 2. Design a function trip-length that computes the length of a Trip.
;; In other words, this function should compute how much ink is used by the given Trip.
;; That is the total amount of ink used by all the Steps in the Trip.
;; Hint: Follow the template for processing a Trip, so use step-length and trip-length.
(define trip-length
  (λ (t)
    (cond
      ((null? t) 0)
      ((cons? t) (+ (step-length (first t)) (trip-length (rest t)))))))

(trip-length z-trip)
(trip-length square-trip)

; A Turtle is (make-turtle Number Number Number)
; *Interpretation*: dir=0 faces east,
;                   dir=90 faces north,
;                   dir=180 faces west,
;                   dir=270 faces south
(define-struct turtle [x y dir])
#;(define (process-turtle t)
  (... (turtle-x t) (turtle-y t) (turtle-dir t) ...))
(define t (make-turtle 24 25 90))
(turtle-x t)
(turtle-y t)
(turtle-dir t)

;; Exercise 3. Design a function move that takes a Step and a Turtle before taking the step and computes the Turtle after taking the step.
;; For example, if the turtle is currently facing north, then taking the step (make-turn 45) should turn the turtle to face northwest,
;; whereas taking the step (make-turn -90) should turn the turtle to face east.
;; To take another example, if the turtle is currently facing north, then taking the step (make-draw 50) should decrease the y coordinate by 50.
;; More generally, if the turtle is currently facing dir, then taking the step (make-draw 50) should decrease the y coordinate by
;; 50 * sin(dir * pi / 180)
;; and increase the x coordinate by
;; 50 * cos(dir * pi / 180)
(define move
  (λ (s t)
    (cond
      ((turn? s)
       (make-turtle (turtle-x t)
                    (turtle-y t)
                    (+ (turn-angle s) (turtle-dir t))
                    ))
      ((draw? s)
       (make-turtle (+ (turtle-x t) (* (draw-distance s) (cos ( / ( * (turtle-dir t) pi) 180))))
                    (- (turtle-y t) (* (draw-distance s) (sin ( / ( * (turtle-dir t) pi) 180))))
                    (turtle-dir t))))))

;; Exercise 4. Design a function draw-step that draws a given Step taken by a given Turtle on a given Image.
;; Use the function scene+line provided by the 2htdp/image library in your examples and your definition; choose your favorite color.
;; Also use the function move you just designed. Recall that turning doesn’t draw anything.
(define draw-step
  (λ (s t i)
    (cond
      ((turn? s) i) 
      ((draw? s) (scene+line i
                     (turtle-x t)
                     (turtle-y t)
                     (turtle-x (move s t))
                     (turtle-y (move s t))
                     "red")))))

(draw-step (make-draw 100) (make-turtle 60 50 270) (empty-scene 200 200))
(draw-step (make-turn 90) (make-turtle 60 50 270) (empty-scene 200 200))

;; Exercise 5. Now design a function draw-trip that draws a given Trip taken by a given Turtle on a given Image. Use the functions move and draw-step you just designed.

;; Try draw-trip on example trips such as square-trip and z-trip.

(define draw-trip
  (λ (ls t i)
    (cond
      ((null? ls) i)
      ((cons? ls) (draw-trip
                   (rest ls)
                   (move (first ls) t)
                   (draw-step (first ls) t i))))))

(draw-trip square-trip (make-turtle 100 123 45) (empty-scene 200 200))
(draw-trip z-trip (make-turtle 50 140 90) (empty-scene 200 200))

;; Exercise 6
(define repeat
  (λ (n t)
    (cond
      ((= n 0) empty)
      (else (append t (repeat (sub1 n) t))))))

(define hexagon-trip
  (repeat 6 (list (make-draw 50) (make-turn 60))))

(define ring-trip
  (repeat 36 (list (make-draw 100) (make-turn 130))))

(draw-trip hexagon-trip (make-turtle 100 123 45) (empty-scene 200 200))

(draw-trip ring-trip (make-turtle 100 123 45) (empty-scene 200 200))