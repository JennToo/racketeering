#lang racket

(module+ test
  (require rackunit))

(define options '(rock paper scissors))
(define which-beats-what '((paper rock) (rock scissors) (scissors paper)))

(define (determine-winner mine yours)
  (if (eq? mine yours)
      "Draw!"
      (let ([lookup (assoc mine which-beats-what)])
        (if lookup
            (if (eq? yours (second lookup)) "You win!" "You lose!")
            (format "What is ~a?" mine)))))

(module+ test
  (check-equal? (determine-winner 'rock 'paper) "You lose!")
  (check-equal? (determine-winner 'rock 'rock) "Draw!")
  (check-equal? (determine-winner 'rock 'scissors) "You win!")
  (check-equal? (determine-winner 'stick 'scissors) "What is stick?"))

(define (ai)
  (let ([index (random (length options))]) (list-ref options index)))

(define (get-player-move)
  (write-string "What is your move? ")
  (string->symbol (read-line)))

(define (play)
  (let ([player-move (get-player-move)] [ai-move (ai)])
    (write-string (format "Computer chose ~a\n" ai-move))
    (write-string (format "~a\n" (determine-winner player-move ai-move)))))

(define (play-forever)
  (play)
  (play-forever))

(module* main #f
  (play-forever))
