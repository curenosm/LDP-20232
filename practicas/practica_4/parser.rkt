;; Miembros del equipo:
;;
;;  - Cureño Sanchez Misael         418002485
;;  - López Carrillo Alan Ignacio   420014760
;;  - Gonzalez Mancera Ivette       316014490
;;  - Reyes López Eduardo Alfonso   420003681

#lang plai

;; Importando el archivo donde se declara la gramática de WBAE
(require "grammars.rkt")


;; Mensajes de error
(define error-paridad       "Paridad incorrecta.")
(define error-operacion     "Operacion incorrecta.")
(define error-not-wbae      "No es una expresion WBAE.")
(define error-lista-vacia   "Lista vacía.")
(define error-wbae-not-id   "La primer entrada del binding introducido no es un symbol.")
(define (error-parse-binding b)
  (string-replace 
    (string-replace 
      (string-append
        "Binding " (format "~a" b) " mal formado") 
        "("
        "[")
      ")"
      "]"))


;; Parse :: s-expression -> WBAE
(define (parse expr)
  (with-handlers 
    ([exn:fail? (λ (exn) (exn-message exn))])
    (cond
      ;; Alias en nuestro lenguaje
      [(equal? 'true expr)  (bool #t)]
      [(equal? 'false expr) (bool #f)]
      [(symbol?  expr) (id   expr)]
      [(number?  expr) (num  expr)]
      [(boolean? expr) (bool expr)]
      [(char?    expr) (chaR expr)]
      [(string?  expr) (strinG  expr)]
      [(list?    expr)
        (if (empty? expr)
          (lst empty)
          (if (and (= 2 (length expr)) (symbol? (car expr)))
            (parse (second expr))
            (case (car expr)
              ['list          (lst (map parse (cdr expr)))]
              ['list?         (op lst?           (check-parity      'list?         (cdr expr)))]
              ['+             (op +              (check-parity      '+             (cdr expr)))]
              ['-             (op -              (check-parity      '-             (cdr expr)))]
              ['*             (op *              (check-parity      '*             (cdr expr)))]
              ['/             (op /              (check-parity      '/             (cdr expr)))]
              ['=             (op =              (check-parity      '=             (cdr expr)))]
              ['<             (op <              (check-parity      '<             (cdr expr)))]
              ['>             (op >              (check-parity      '>             (cdr expr)))]
              ['<=            (op <=             (check-parity      '<=            (cdr expr)))]
              ['>=            (op >=             (check-parity      '>=            (cdr expr)))]
              ['bool?         (op bool?          (check-parity      'bool?         (cdr expr)))]
              ['char?         (op char?          (check-parity      'char?         (cdr expr)))]
              ['empty?        (op empty?         (check-parity      'empty?        (cdr expr)))]
              ['num?          (op num?           (check-parity      'num?          (cdr expr)))]
              ['string?       (op string?        (check-parity      'string?       (cdr expr)))]
              ['zero?         (op zero?          (check-parity      'zero?         (cdr expr)))]
              ['add1          (op add1           (check-parity      'add1          (cdr expr)))]
              ['and           (op anD            (check-parity      'anD           (cdr expr)))]
              ['car           (op car            (check-parity      'car           (cdr expr)))]
              ['cdr           (op cdr            (check-parity      'cdr           (cdr expr)))]
              ['expt          (op expt           (check-parity      'expt          (cdr expr)))]
              ['length        (op length         (check-parity      'length        (cdr expr)))]
              ['max           (op max            (check-parity      'max           (cdr expr)))]
              ['min           (op min            (check-parity      'min           (cdr expr)))]
              ['modulo        (op modulo         (check-parity      'modulo        (cdr expr)))]
              ['not           (op not            (check-parity      'not           (cdr expr)))]
              ['or            (op oR             (check-parity      'oR            (cdr expr)))]
              ['sqrt          (op sqrt           (check-parity      'sqrt          (cdr expr)))]
              ['string-length (op string-length  (check-parity      'string-length (cdr expr)))]
              ['sub1          (op sub1           (check-parity      'sub1          (cdr expr)))]
              ['with          (with              (map parse-binding (second expr)) (parse (third expr)))]
              ['with*         (with*             (map parse-binding (second expr)) (parse (third expr)))]
              [else           (parse (car expr))])))]
      [else (error error-not-wbae)])))


;; Función que nos ayuda a transformar una expresion de WBAE a otra donde los with*
;; fueron cambiados por with anidados
(define (desugar expr)
  (type-case WBAE expr
    [bool (b) expr]
    [num  (n) expr]
    [with (list-bindings body)
      (if (empty? list-bindings)
        body
        (with (list (first list-bindings))
          (desugar
            (with (cdr list-bindings) body))))]
    [with* (list-bindings body)
      (if (empty? list-bindings)
        body
        (with (list (first list-bindings))
          (desugar
            (with* (cdr list-bindings) body))))]
    [else expr]))


;; Por sintaxis del lenguaje solo se permiten listas de dos
;; elementos para los bindings, además, el primer elemento debe de ser
;; un WBAE id, de manera estricta
(define (parse-binding expr)
  (if (not (= 2 (length expr)))
    (error (error-parse-binding expr))
    (if (not (symbol? (first expr)))
      (error error-wbae-not-id)
      (binding (first expr) (parse (second expr))))))


;; Función auxiliar para verificar la paridad de las operaciones definidas en
;; nuestro lenguaje.
(define (check-parity f l)
  (define len (length l))
  (case f
    ['modulo        (if (= 2 len) (list  (parse (car l)))   (print-error-paridad 2 len))]
    ['expt          (if (= 2 len) (list  (parse (car l)))   (print-error-paridad 2 len))]
    ['not           (if (= 1 len) (list  (parse (car l)))   (print-error-paridad 1 len))]
    ['add1          (if (= 1 len) (list  (parse (car l)))   (print-error-paridad 1 len))]
    ['sub1          (if (= 1 len) (list  (parse (car l)))   (print-error-paridad 1 len))]
    ['car           (if (= 1 len) (list  (parse (car l)))   (print-error-paridad 1 len))]
    ['cdr           (if (= 1 len) (list  (parse (car l)))   (print-error-paridad 1 len))]
    ['length        (if (= 1 len) (list  (parse (car l)))   (print-error-paridad 1 len))]
    ['string-length (if (= 1 len) (list  (parse (car l)))   (print-error-paridad 1 len))]
    ['list?         (if (= 1 len) (parse (cdr   (car l)))   (print-error-paridad 1 len))]
    ['list          (if (< 1 len) (map    parse l)          (print-error-paridad 1 len))]
    [else           (if (< 1 len) (map parse l) (print-error-paridad 2 len))]))


;; Funcion auxiliar para imprimir los errores de paridad
(define (print-error-paridad args-esperados args-provistos)
  (define err-msg
    (string-append
      error-paridad
      "\nSe esperaban: "
      (number->string args-esperados)
      " argumentos, pero se obtuvo: "
      (number->string args-provistos)
      " argumentos. "))
  (error err-msg))


;; anD :: list  -> bool
(define (anD l)
  (if (empty? (lst-l l))
    (bool #t)
    (if (eq? (bool-b (car (lst-l l))) #f)
      (bool #f)
      (anD (lst (cdr (lst-l l)))))))


;; oR :: list  -> bool
(define (oR l)
  (if (empty? (lst-l l))
    (bool #f)
    (if (eq? (bool-b (car (lst-l l))) #t)
      (bool #t)
      (oR (lst (cdr (lst-l l)))))))


