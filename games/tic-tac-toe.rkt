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

(define (line-get-winner line)
  (foldl (λ (x y) (if (equal? x y) x #f)) (first line) (rest line)))

(define (board-iter-lines board)
  (define ranges-to-check
    (append (map (λ (x) (map cons (range 0 3) (list x x x))) (range 0 3))
            (map (λ (x) (map cons (list x x x) (range 0 3))) (range 0 3))
            ; Diagonals
            '(((0 . 0) (1 . 1) (2 . 2)) ((2 . 0) (1 . 1) (0 . 2)))))
  ; TODO
  '())

(define (board-get-winner board)
  (ormap line-get-winner (board-iter-lines board)))

(module+ test
  (check-equal? (line-get-winner '(blank x x)) #f)
  (check-equal? (line-get-winner '(x x blank)) #f)
  (check-equal? (line-get-winner '(x x x)) 'x))
