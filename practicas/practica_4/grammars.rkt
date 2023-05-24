;; Miembros del equipo:
;;
;;  - Cureño Sanchez Misael         418002485
;;  - López Carrillo Alan Ignacio   420014760
;;  - Gonzalez Mancera Ivette       316014490
;;  - Reyes López Eduardo Alfonso   420003681

#lang plai

;; Definición del lenguaje WBAE


;; Definición tipo Binding
(define-type Binding
  [binding (id symbol?) (value WBAE?)])


;; Tipo WBAE
(define-type WBAE
  [id     (i        symbol? )]
  [num    (n        number? )]
  [bool   (b        boolean?)]
  [chaR   (c        char?   )]
  [strinG (s        string? )]
  [op     (f        procedure?)  (args (listof WBAE?))]
  [lst    (l                           (listof WBAE?))]
  [with   (bindings (listof binding?))    (body WBAE?)]
  [with*  (bindings (listof binding?))    (body WBAE?)])