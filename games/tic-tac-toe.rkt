#lang racket

(require lens)

(module+ test
  (require rackunit))

(define blank-board
  '((blank blank blank) (blank blank blank) (blank blank blank)))

(define (board-update board x y value)
  (lens-set (list-ref-nested-lens x y) board value))

(module+ test
  (define expected-update
    '((blank blank blank) (blank x blank) (blank blank blank)))
  (check-equal? (board-update blank-board 1 1 'x) expected-update))

(define (board-render board)
  (define (slot-render slot)
    (cond
      [(equal? slot 'x) "X"]
      [(equal? slot 'y) "Y"]
      [else "_"]))
  (define (line-render line)
    (apply ~a (map slot-render line)))
  (apply ~a #:separator "\n" (map line-render board)))

(module+ test
  (check-equal? (board-render blank-board) "___\n___\n___"))
