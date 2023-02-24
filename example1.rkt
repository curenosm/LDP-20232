#lang racket/gui
 
(define secret (random 5))
 
(define f (new frame% [label "Adivina el número"])) ; Ventana principal
(define t (new message% [parent f]
               [label "¿Puedes adivinar el numero que estoy pensando?"]))
(define p (new horizontal-pane% [parent f]))    ; Contenedor horizontal
 
(define ((make-check i) btn evt)
  (message-box "." (cond [(< i secret) "Demasiado pequeño"]
                         [(> i secret) "Demasiado grande"]
                         [else         "¡Exacto!"]))
  (when (= i secret) (send f show #f)))         ; Se ha adivinado, por lo que cerramos la ventana
 
(for ([i (in-range 10)])                        ; Creamos los botones
  (make-object button% (format "~a" i) p (make-check i)))
 
(send f show #t) ; Mostramos la ventana, comenzando la aplicación