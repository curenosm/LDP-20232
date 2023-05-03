;; Miembros del equipo:
;;  - Cureño Sanchez Misael, 418002485
;;  - López Carrillo Alan Ignacio, 420014760
;;  - Gonzalez Mancera Ivette, 316014490
;;  - Reyes López Eduardo Alfonso, 420003681

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#lang plai

;; Importando las definiciones de los tipos de datos
(require "datatypes.rkt")

;; Recuerda realizar en orden ejercicios correspondientes a la práctica

;; Ejercicio 2:  En clase, definimos el TDA pilas-y-colas y los respectivos constructores necesarios.

;; 1. Define la el predicado (contains? struct elem) que recibe una estructura de datos y un elemento 
;; cualquiera, determina si dicho elemento se encuentra almacenado en la estructura pasada como 
;; parámetro

(define (contains? struct elem)
  (type-case pilas-y-colas struct
    [pila (nodos) (contiene? nodos elem)]
    [cola (nodos) (contiene? nodos elem)]))

;; Funcion que nos indica si un elemento elem está dentro de alguno de los nodos
(define (contiene? nodos elem)
  (type-case Nodo nodos
    [Void () #f]
    [nodo (e s) 
      (if (= e elem)
        #t
        (contains? s elem))]))

;; 2. Define la función (mira struct) la cual recibe una estructura (struct) y regresa el elemento que se
;; encuentra en el tope de la estructura, i.e. el elemento que sería eliminado de la estructura al 
;; llamar a la función (saca struct).

(define (mira struct)
  (type-case pilas-y-colas struct
    [pila (nodos) (obten-final nodos)]
    [cola (nodos) (obten-inicio nodos)]))

;; Funcion que nos ayuda a obtener el primer elemento dados los nodos
(define (obten-inicio nodos)
  (type-case Nodo nodos
    [Void () Void]
    [nodo (e s) e]))

;; Funcion que nos ayuda a obtener el ultimo elemento dados los nodos
(define (obten-final nodos)
  (type-case Nodo nodos
    [Void () Void]
    [nodo (e s)
      (if (equal? s (Void)) ;; Si ya es el ultimo nodo, devuelve su elemento
          e
          (obten-final s))]))

;; 3. . Define la función (size struct) la cual determina la cantidad de elementos en la estructura.
;; Si la estructura es vacía, el número de elemento es igual a cero.

(define (size struct)
  (type-case pilas-y-colas struct
    [pila (nodos) (cuenta nodos)]
    [cola (nodos) (cuenta nodos)]))

;; Funcion que nos ayuda a calcular el numero de elementos dados los nodos de la estructura
(define (cuenta nodos)
  (type-case Nodo nodos
    [Void () 0]
    [nodo (e s) (+ 1 (cuenta s))]))
