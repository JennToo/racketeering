#lang racket/gui

(provide main)
(define (main . xs)
  ; Scaffolding from examples
  (define frame (new frame% [label "Example"]))
  (define msg (new message% [parent frame] [label "No events so far..."]))
  (new button%
       [parent frame]
       [label "Click Me"]
       ; Callback procedure for a button click:
       [callback (lambda (button event) (send msg set-label "Button click"))])
  (send frame show #t))
