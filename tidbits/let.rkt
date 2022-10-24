#lang racket

(module+ test
  (require rackunit))

(define (function-1 x y z)
  (let ([w (* x y)] [i (+ y z)]) (+ x y w (/ w i))))

(define (function-2 x y z)
  ((λ (w i) (+ x y w (/ w i))) (* x y) (+ y z)))

(module+ test
  (check-equal? (function-1 1 2 3) (function-2 1 2 3)))
