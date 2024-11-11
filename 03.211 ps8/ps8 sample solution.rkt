;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |ps8 sample solution|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
;; #reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname turtle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; Examples of Trips
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
(define trip1 ; shaped like L
  (list (make-draw 100)
        (make-turn 90)
        (make-draw 80)))
(define trip2 ; shaped like how some people write 4
  (list (make-draw 100)
        (make-turn 120)
        (make-draw 50)
        (make-turn -90)
        (make-draw 30)))

; Templates for processing a Step and a Trip
(define (process-step s)
  (cond [(draw? s) (... (draw-distance s))]
        [(turn? s) (... (turn-angle s))]))
(define (process-trip t)
  (cond [(empty? t) ...]
        [(cons? t) (... (process-step (first t))
                        (process-trip (rest t)))]))

; step-length : Step -> Number
; compute the length of a Step
(check-expect (step-length (make-draw 100)) 100)
(check-expect (step-length (make-turn 90)) 0)
(define (step-length s)
  (cond [(draw? s) (draw-distance s)]
        [(turn? s) 0]))

; trip-length : Trip -> Number
; compute the length of a Trip
(check-expect (trip-length empty) 0)
(check-expect (trip-length trip1) 180)
(check-expect (trip-length trip2) 180)
(define (trip-length t)
  (cond [(empty? t) 0]
        [(cons? t) (+ (step-length (first t))
                      (trip-length (rest t)))]))

; A Turtle is (make-turtle Number Number Number)
; *Interpretation*: dir=0 faces east,
;                   dir=90 faces north,
;                   dir=180 faces west,
;                   dir=270 faces south
(define-struct turtle [x y dir])

; move : Step Turtle -> Turtle
; compute the turtle after taking the step
(check-within (move (make-draw 100) (make-turtle 60 50 270))
              (make-turtle 60 150 270)
              .001)
(check-expect (move (make-turn 90) (make-turtle 60 50 270))
              (make-turtle 60 50 360))
(define (move s k)
  (cond [(draw? s)
         (make-turtle (+ (turtle-x k)
                         (* (draw-distance s)
                            (cos (turtle-rad k))))
                      (- (turtle-y k)
                         (* (draw-distance s)
                            (sin (turtle-rad k))))
                      (turtle-dir k))]
        [(turn? s)
         (make-turtle (turtle-x k)
                      (turtle-y k)
                      (+ (turtle-dir k) (turn-angle s)))]))

; turtle-rad : Turtle -> Number
; compute the turtle's direction in radians
(check-within (turtle-rad (make-turtle 60 50 270)) (* 1.5 pi) .001)
(check-expect (turtle-rad (make-turtle 60 50 0)) 0)
(define (turtle-rad k)
  (* (turtle-dir k) (/ pi 180)))

; draw-step : Step Turtle Image -> Image
; draw the given step taken by the given turtle on the given image
(check-expect (draw-step (make-draw 100) (make-turtle 60 50 270) (empty-scene 200 200))
              (scene+line (empty-scene 200 200) 60 50 60 150 "orange"))
(check-expect (draw-step (make-turn 90) (make-turtle 60 50 270) (empty-scene 200 200))
              (empty-scene 200 200))
(define (draw-step s k i)
  (cond [(draw? s)
         (scene+line i
                     (turtle-x k)
                     (turtle-y k)
                     (turtle-x (move s k))
                     (turtle-y (move s k))
                     "orange")]
        [(turn? s) i]))

; draw-trip : Trip Turtle Image -> Image
; draw the given trip taken by the given turtle on the given image
(check-expect (draw-trip empty (make-turtle 60 50 270) (empty-scene 200 200))
              (empty-scene 200 200))
(check-expect (draw-trip trip1 (make-turtle 60 50 270) (empty-scene 200 200))
              (scene+line (scene+line (empty-scene 200 200)
                                      60 50 60 150 "orange")
                          60 150 140 150 "orange"))
(check-expect (draw-trip trip2 (make-turtle 100 33.397 240) (empty-scene 200 200))
              (scene+line (scene+line (scene+line (empty-scene 200 200)
                                                  100 33.397 50 120 "orange")
                                      50 120 100 120 "orange")
                          100 120 100 150 "orange"))
(define (draw-trip t k i)
  (cond [(empty? t) i]
        [(cons? t)
         (draw-trip (rest t)
                    (move (first t) k)
                    (draw-step (first t) k i))]))

(draw-trip square-trip (make-turtle 100 123 45) (empty-scene 200 200))
(draw-trip z-trip (make-turtle 50 140 90) (empty-scene 200 200))

; repeat : NaturalNumber Trip -> Trip
; repeat the given trip the given number of times
(check-expect (repeat 0 trip1) empty)
(check-expect (repeat 2 trip1)
              (list (make-draw 100) (make-turn 90) (make-draw 80)
                    (make-draw 100) (make-turn 90) (make-draw 80)))
(define (repeat n t)
  (cond [(= n 0) empty]
        [else (append t (repeat (- n 1) t))]))

(define hexagon-trip
  (repeat 6 (list (make-draw 50) (make-turn 60))))
(draw-trip hexagon-trip (make-turtle 50 50 90) (empty-scene 200 200))

(define ring-trip
  (repeat 36 (list (make-draw 100) (make-turn 130))))
(draw-trip ring-trip (make-turtle 50 50 90) (empty-scene 200 200))