#lang plai

;; Sintaxis Concreta
;; Lenguaje RCFWAE
;; Versión Glotona con Alcance Estático
;; <expr> ::= <id>
;;          | <num>
;;          | {+ <expr> <expr>}
;;          | {- <expr> <expr>}
;;          | {* <expr> <expr>}
;;          | {if0 <expr> <expr> <expr>}
;;          | {with {<id> <expr>} <expr>}
;;          | {rec {<id> <expr>} <expr>}
;;          | {fun {<id>} <expr>}
;;          | {<expr> <expr>}

;; Sintaxis abstracta
(define-type ASA
  [id (i symbol?)]
  [num (n number?)]
  [add (i ASA?) (d ASA?)]
  [sub (i ASA?) (d ASA?)]
  [plus (i ASA?) (d ASA?)]
  [if0 (cond-expr ASA?) (then-expr ASA?) (else-expr ASA?)]
  [rec (id symbol?) (value ASA?) (body ASA?)]
  [fun (param symbol?) (body ASA?)]
  [app (fun-expr ASA?) (arg ASA?)])

;; Valores para el regreso del intérprete.
(define-type ASA-Value
  [numV (n number?)]
  [closureV (param symbol?) (body ASA?) (env Env?)])

;; Verificación de la estructura del ambiente recursivo.
;; boxed-ASA-Value?: any -> boolean
(define (boxed-ASA-Value? v)
  (and (box? v) (ASA-Value? (unbox v))))

;; Ambientes de evaluación.
;; Almacenan parejas (id,valor)
(define-type Env
  [mtSub]
  [aRecSub (id symbol?) (value boxed-ASA-Value?) (rest-env Env?)]
  [aSub (id symbol?) (value ASA-Value?) (rest-env Env?)])


;; lookup symbol Env -> ASA
;; Búsqueda de un id en el ambiente.
(define (lookup sub-id env)
  (match env
    [(mtSub) (error 'lookup "Variable libre")]
    [(aSub i v r)
        (if (equal? i sub-id)
            v
            (lookup sub-id r))]
    [(aRecSub i v r)
        (if (equal? i sub-id)
            (unbox v) ;; Paso 3
            (lookup sub-id r))]))

;; Función que realiza la creación del ambiente recursivo e interpete. En pocas palabras aplica 
;; la regla de los tres pasos.
;; cyclically-bind-and-interp: symbol ASA Env -> Env
(define (cyclically-bind-and-interp id value env)
  (let* ([contenedor (box (numV 1729))] ; ; Paso 1
        [ambiente (aRecSub id contenedor env)]
        [valor (interp value ambiente)])
    (begin
      (set-box! contenedor valor) ; ; Paso 2
      ambiente)))

;; interp: ASA -> ASA
;; Intérprete para CFAE, toma una expresión en sintaxis abstracta y nos devuelve el resultado de
;; evaluar dicha expresión.
(define (interp expr env)
  (match expr
    [(id i) 
      (lookup i env)]
    [(num n) 
      (numV n)]
    [(add i d) 
      (numV (+ (numV-n (interp i env)) (numV-n (interp d env))))]
    [(sub i d) 
      (numV (- (numV-n (interp i env)) (numV-n (interp d env))))]
    [(plus i d) 
      (numV (* (numV-n (interp i env)) (numV-n (interp d env))))]
    [(if0 cond-expr then-expr else-expr)
      (if (zero? (numV-n (interp cond-expr env)))
          (interp then-expr env)
          (interp else-expr env))]
    [(rec id value body)
      (interp body (cyclically-bind-and-interp id value env))]
    [(fun p b) 
      (closureV p b env)]
    [(app f a)
        (let ([fun-val (interp f env)])
          (interp (closureV-body fun-val)
                  (aSub (closureV-param fun-val) (interp a env) (closureV-env fun-val))))]))

; Prueba
;; {rec {f {fun {n} {if0 n 1 {* n {f {- n 1}}}}}}
;;    {f 5}}
;; Debe dar 120 (Lo hace por el alcance dinámico)
(define expr 
  (rec 'f (fun 'n (if0 (id 'n) (num 1) (plus (id 'n) (app (id 'f) (sub (id 'n) (num 1))))))
    (app (id 'f) (num 5))))
