;;  - Cureño Sanchez Misael, 418002485

#lang plai

;; Importando las definiciones de los tipos de datos
(require "datatypes.rkt")

;;Definiendo algunas pilas y colas útiles para el ejemplo
(define p (pila (nodo 1 (nodo 2 (nodo 3 (nodo 4 (nodo 5 (Void))))))))

(define c (cola (nodo 323 (nodo 2342 (nodo 32112 (Void))))))

;; Ejercicio 1: Define la función (cool-print struct) tal que dado un ejemplar de pilas-y-colas 
;; imprima en pantalla una representación gráfica “más amigable” de la estructura pasada como 
;; parámetro

;; Funcion principal del ejercicio Extra 1
(define (cool-print struct)
  (type-case pilas-y-colas struct
    [pila (nodos)
      (display
        (string-append "[" (cool-print-nodos nodos) "]<->"))]
    [cola (nodos)
      (display 
        (string-append "<-[" (cool-print-nodos nodos) "]<-"))]))

;; Funcion para imprimir unicamente los elementos separados por espacios
(define (cool-print-nodos nodos)
  (type-case Nodo nodos
    [Void () ""]
    [nodo (e s)
      (string-append 
        (number->string e)
        (if (equal? (Void) s) "" " ") ;; Si no es el ultimo elemento, agrega un separador
        (cool-print-nodos s))]))